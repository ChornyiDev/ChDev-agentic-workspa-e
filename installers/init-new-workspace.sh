#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/workspace-templates/Basic"
LIBRARY_DIR="$REPO_ROOT/agent-library"
BUNDLE_FILE="$LIBRARY_DIR/bundles/basic.yaml"

TARGET_INPUT=""
PROJECT_NAME=""
PROFILE=""
OPTIONAL_SKILLS=""
OPTIONAL_WORKFLOWS=""
INIT_GIT=false
BUILD_DIR=""

usage() {
  cat <<'EOF'
Initialize a new workspace from the Basic template.

Usage:
  init-new-workspace.sh --target PATH [options]

Required:
  --target PATH              New or empty target directory.

Options:
  --name NAME                Project name. Defaults to the target directory name.
  --profile PROFILE          nextjs or flutterflow. Prompted when omitted.
  --skills LIST              Comma-separated optional skill names.
  --workflows LIST           Comma-separated optional workflow names.
  --git-init                 Initialize a Git repository after installation.
  -h, --help                 Show this help.

Safety:
  This installer refuses to run against a non-empty directory. Existing
  workspaces must be adopted with installers/ADOPT_EXISTING_WORKSPACE.md.
EOF
}

fail() {
  printf 'Error: %s\n' "$1" >&2
  exit 1
}

cleanup() {
  if [[ -n "$BUILD_DIR" && -d "$BUILD_DIR" ]]; then
    rm -rf "$BUILD_DIR"
  fi
}

trap cleanup EXIT

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      [[ $# -ge 2 ]] || fail "--target requires a path"
      TARGET_INPUT="$2"
      shift 2
      ;;
    --name)
      [[ $# -ge 2 ]] || fail "--name requires a value"
      PROJECT_NAME="$2"
      shift 2
      ;;
    --profile)
      [[ $# -ge 2 ]] || fail "--profile requires nextjs or flutterflow"
      PROFILE="$2"
      shift 2
      ;;
    --skills)
      [[ $# -ge 2 ]] || fail "--skills requires a comma-separated list"
      OPTIONAL_SKILLS="$2"
      shift 2
      ;;
    --workflows)
      [[ $# -ge 2 ]] || fail "--workflows requires a comma-separated list"
      OPTIONAL_WORKFLOWS="$2"
      shift 2
      ;;
    --git-init)
      INIT_GIT=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      fail "unknown argument: $1"
      ;;
  esac
done

[[ -d "$TEMPLATE_DIR" ]] || fail "template not found: $TEMPLATE_DIR"
[[ -d "$LIBRARY_DIR" ]] || fail "agent library not found: $LIBRARY_DIR"
[[ -f "$BUNDLE_FILE" ]] || fail "Basic bundle not found: $BUNDLE_FILE"

if [[ -z "$TARGET_INPUT" ]]; then
  read -r -p "Target directory: " TARGET_INPUT
fi

[[ -n "$TARGET_INPUT" ]] || fail "target directory is required"

TARGET_PARENT_INPUT="$(dirname "$TARGET_INPUT")"
TARGET_BASENAME="$(basename "$TARGET_INPUT")"

[[ "$TARGET_BASENAME" != "." && "$TARGET_BASENAME" != ".." && "$TARGET_BASENAME" != "/" ]] \
  || fail "target must be a specific workspace directory"

mkdir -p "$TARGET_PARENT_INPUT"
TARGET_PARENT="$(cd "$TARGET_PARENT_INPUT" && pwd)"
TARGET_DIR="$TARGET_PARENT/$TARGET_BASENAME"

[[ "$TARGET_DIR" != "/" && "$TARGET_DIR" != "$REPO_ROOT" && "$TARGET_DIR" != "$TEMPLATE_DIR" ]] \
  || fail "refusing unsafe target: $TARGET_DIR"

if [[ -e "$TARGET_DIR" && ! -d "$TARGET_DIR" ]]; then
  fail "target exists and is not a directory: $TARGET_DIR"
fi

if [[ -d "$TARGET_DIR" ]] && [[ -n "$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
  fail "target is not empty. Use installers/ADOPT_EXISTING_WORKSPACE.md for an existing workspace"
fi

if [[ -z "$PROJECT_NAME" ]]; then
  PROJECT_NAME="$TARGET_BASENAME"
fi

if [[ -z "$PROFILE" ]]; then
  read -r -p "Technology profile (nextjs/flutterflow): " PROFILE
fi

case "$PROFILE" in
  nextjs|flutterflow) ;;
  *) fail "profile must be nextjs or flutterflow" ;;
esac

bundle_list() {
  local desired_profile="$1"
  local desired_kind="$2"

  awk -v desired_profile="$desired_profile" -v desired_kind="$desired_kind" '
    function key(line) {
      sub(/^[ ]+/, "", line)
      sub(/:.*/, "", line)
      return line
    }
    /^[^ ]/ {
      top = key($0)
      current_profile = ""
      current_kind = ""
      next
    }
    /^  [^ ]/ {
      value = key($0)
      if (top == "common") {
        current_profile = "common"
        current_kind = value
      } else if (top == "profiles") {
        current_profile = value
        current_kind = ""
      }
      next
    }
    /^    [^ -]/ {
      if (top == "profiles") {
        current_kind = key($0)
      }
      next
    }
    /^    - / {
      if (top == "common" && current_kind == desired_kind) {
        value = $0
        sub(/^    - /, "", value)
        print value
      }
      next
    }
    /^      - / {
      if (top == "profiles" && current_profile == desired_profile && current_kind == desired_kind) {
        value = $0
        sub(/^      - /, "", value)
        print value
      }
    }
  ' "$BUNDLE_FILE"
}

append_unique() {
  local list="$1"
  local value="$2"

  [[ -n "$value" ]] || {
    printf '%s' "$list"
    return
  }

  if printf '%s\n' "$list" | grep -Fxq "$value"; then
    printf '%s' "$list"
  elif [[ -n "$list" ]]; then
    printf '%s\n%s' "$list" "$value"
  else
    printf '%s' "$value"
  fi
}

append_csv() {
  local list="$1"
  local csv="$2"
  local item=""
  local old_ifs="$IFS"

  IFS=','
  for item in $csv; do
    item="$(printf '%s' "$item" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
    list="$(append_unique "$list" "$item")"
  done
  IFS="$old_ifs"
  printf '%s' "$list"
}

SKILLS="$(bundle_list common skills)"
PROFILE_SKILLS="$(bundle_list "$PROFILE" skills)"
WORKFLOWS="$(bundle_list common workflows)"
PROFILE_WORKFLOWS="$(bundle_list "$PROFILE" workflows)"

while IFS= read -r item; do
  [[ -n "$item" ]] && SKILLS="$(append_unique "$SKILLS" "$item")"
done <<< "$PROFILE_SKILLS"

while IFS= read -r item; do
  [[ -n "$item" ]] && WORKFLOWS="$(append_unique "$WORKFLOWS" "$item")"
done <<< "$PROFILE_WORKFLOWS"

SKILLS="$(append_csv "$SKILLS" "$OPTIONAL_SKILLS")"
WORKFLOWS="$(append_csv "$WORKFLOWS" "$OPTIONAL_WORKFLOWS")"

while IFS= read -r skill; do
  [[ -z "$skill" ]] && continue
  [[ -f "$LIBRARY_DIR/skills/$skill/SKILL.md" ]] || fail "unknown skill: $skill"
done <<< "$SKILLS"

while IFS= read -r workflow; do
  [[ -z "$workflow" ]] && continue
  [[ -f "$LIBRARY_DIR/workflows/$workflow.md" ]] || fail "unknown workflow: $workflow"
done <<< "$WORKFLOWS"

BUILD_DIR="$(mktemp -d "$TARGET_PARENT/.workspace-init.XXXXXX")"
cp -R "$TEMPLATE_DIR/." "$BUILD_DIR/"

rm -rf "$BUILD_DIR/.agents/skills" "$BUILD_DIR/.agents/workflows"
mkdir -p "$BUILD_DIR/.agents/skills" "$BUILD_DIR/.agents/workflows"

while IFS= read -r skill; do
  [[ -z "$skill" ]] && continue
  cp -R "$LIBRARY_DIR/skills/$skill" "$BUILD_DIR/.agents/skills/$skill"
done <<< "$SKILLS"

while IFS= read -r workflow; do
  [[ -z "$workflow" ]] && continue
  cp "$LIBRARY_DIR/workflows/$workflow.md" "$BUILD_DIR/.agents/workflows/$workflow.md"
done <<< "$WORKFLOWS"

if [[ -z "$SKILLS" ]]; then
  touch "$BUILD_DIR/.agents/skills/.gitkeep"
fi

if [[ -z "$WORKFLOWS" ]]; then
  touch "$BUILD_DIR/.agents/workflows/.gitkeep"
fi

ACTIVE_PROFILE="$PROFILE" perl -0pi -e '
  if ($ENV{ACTIVE_PROFILE} eq "nextjs") {
    s/<!-- PROFILE:flutterflow:START -->.*?<!-- PROFILE:flutterflow:END -->\n?//s;
    s/<!-- PROFILE:nextjs:(?:START|END) -->\n?//g;
  } else {
    s/<!-- PROFILE:nextjs:START -->.*?<!-- PROFILE:nextjs:END -->\n?//s;
    s/<!-- PROFILE:flutterflow:(?:START|END) -->\n?//g;
  }
' "$BUILD_DIR/AGENTS.md"

ACTIVE_PROFILE="$PROFILE" perl -0pi -e '
  s/<!-- TEMPLATE-STATE:START -->.*?<!-- TEMPLATE-STATE:END -->\n?/- Active technology profile: `$ENV{ACTIVE_PROFILE}`.\n/s;
  s/<!-- TEMPLATE-PROFILE-INSTRUCTIONS:START -->.*?<!-- TEMPLATE-PROFILE-INSTRUCTIONS:END -->\n?/This workspace uses the `$ENV{ACTIVE_PROFILE}` technology profile.\n/s;
  s/^Use this profile only when .*?\.\n\n//m;
' "$BUILD_DIR/AGENTS.md"

ACTIVE_PROFILE="$PROFILE" perl -0pi -e '
  s/<!-- TEMPLATE-SOURCE:START -->.*?<!-- TEMPLATE-SOURCE:END -->\n?/This workspace was initialized from the Basic template with the `$ENV{ACTIVE_PROFILE}` profile.\n/s;
  s/<!-- TEMPLATE-INITIALIZATION-STEPS:START -->.*?<!-- TEMPLATE-INITIALIZATION-STEPS:END -->\n?/2. **Active profile:** `$ENV{ACTIVE_PROFILE}`.\n/s;
  s/^4\. /3. /m;
  s/^5\. /4. /m;
  s/^6\. /5. /m;
' "$BUILD_DIR/README.md"

if [[ "$PROFILE" == "nextjs" ]]; then
  rm -rf "$BUILD_DIR/cloud_functions" "$BUILD_DIR/custom_code" "$BUILD_DIR/docs/flutterflow"
  perl -ni -e 'next if /\# \[flutterflow\]/; s/\# \[nextjs\]/#/; print' "$BUILD_DIR/AGENTS.md"
  perl -ni -e 'print unless /\*\*FlutterFlow\*\*/' "$BUILD_DIR/docs/README.md"
  perl -ni -e 'print unless /\*\*\[cloud_functions\/\]/ || /\*\*\[custom_code\/\]/' "$BUILD_DIR/README.md"
else
  rm -rf "$BUILD_DIR/docs/database" "$BUILD_DIR/docs/prompts"
  perl -ni -e 'next if /\# \[nextjs\]/; s/\# \[flutterflow\]/#/; print' "$BUILD_DIR/AGENTS.md"
  perl -ni -e 'print unless /\*\*Database\*\*/ || /\*\*Prompts\*\*/' "$BUILD_DIR/docs/README.md"
  perl -ni -e 'print unless /\[`database\/`\]/' "$BUILD_DIR/docs/CONTEXT.md"
fi

PROJECT_NAME_VALUE="$PROJECT_NAME" ACTIVE_PROFILE_VALUE="$PROFILE" \
  find "$BUILD_DIR" -type f -print0 | while IFS= read -r -d '' file; do
    case "$file" in
      *.md|*.yaml|*.yml|*.json|*.txt|*.toml|*/.gitignore)
        PROJECT_NAME_VALUE="$PROJECT_NAME" ACTIVE_PROFILE_VALUE="$PROFILE" \
          perl -pi -e 's/\{\{project_name\}\}/$ENV{PROJECT_NAME_VALUE}/g; s/\{\{active_profile\}\}/$ENV{ACTIVE_PROFILE_VALUE}/g' "$file"
        ;;
    esac
  done

if grep -R -n -E '\{\{(project_name|active_profile)\}\}' "$BUILD_DIR" >/dev/null 2>&1; then
  fail "required template placeholders remain unresolved"
fi

rm -f "$BUILD_DIR/template.yaml"
mkdir -p "$BUILD_DIR/.workspace"

YAML_PROJECT_NAME="$(printf '%s' "$PROJECT_NAME" | sed "s/'/''/g")"
{
  printf 'schema_version: 1\n'
  printf 'template:\n'
  printf "  name: 'Basic'\n"
  printf "  version: '0.1.0'\n"
  printf "  profile: '%s'\n" "$PROFILE"
  printf "  project_name: '%s'\n" "$YAML_PROJECT_NAME"
  printf 'agent_assets:\n'
  printf "  bundle: 'basic'\n"
  printf '  skills:\n'
  if [[ -n "$SKILLS" ]]; then
    while IFS= read -r skill; do
      [[ -n "$skill" ]] && printf "    - '%s'\n" "$skill"
    done <<< "$SKILLS"
  else
    printf '    []\n'
  fi
  printf '  workflows:\n'
  if [[ -n "$WORKFLOWS" ]]; then
    while IFS= read -r workflow; do
      [[ -n "$workflow" ]] && printf "    - '%s'\n" "$workflow"
    done <<< "$WORKFLOWS"
  else
    printf '    []\n'
  fi
} > "$BUILD_DIR/.workspace/template.lock.yaml"

if [[ -d "$TARGET_DIR" ]]; then
  rmdir "$TARGET_DIR"
fi

mv "$BUILD_DIR" "$TARGET_DIR"
BUILD_DIR=""

if [[ "$INIT_GIT" == true ]]; then
  command -v git >/dev/null 2>&1 || fail "Git is not installed"
  git -C "$TARGET_DIR" init >/dev/null
fi

display_list() {
  local list="$1"
  if [[ -z "$list" ]]; then
    printf 'none'
  else
    printf '%s\n' "$list" | awk 'BEGIN { first = 1 } { if (!first) printf ", "; printf "%s", $0; first = 0 }'
  fi
}

printf '\nWorkspace initialized successfully.\n'
printf '  Target:   %s\n' "$TARGET_DIR"
printf '  Project:  %s\n' "$PROJECT_NAME"
printf '  Profile:  %s\n' "$PROFILE"
printf '  Skills:   %s\n' "$(display_list "$SKILLS")"
printf '  Workflows: %s\n' "$(display_list "$WORKFLOWS")"
printf '\nReview AGENTS.md and roadmap/specs/ before starting implementation.\n'
