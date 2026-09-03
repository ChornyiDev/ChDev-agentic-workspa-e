#!/bin/bash

# Check for required arguments
TARGET_PATH=$1
SUBDOMAIN=$2

if [ -z "$TARGET_PATH" ] || [ -z "$SUBDOMAIN" ]; then
  echo "❌ Error: Specify source path and subdomain name."
  echo "Example: ./deploy.sh docs/media-plan.md media-plan"
  exit 1
fi

# Path setup
PROJECT_ROOT=$(pwd)
PRESENTATIONS_DIR="$PROJECT_ROOT/presentations"
DEPLOY_DIR="$PRESENTATIONS_DIR/$SUBDOMAIN"
ASSETS_DIR="$DEPLOY_DIR/assets"

echo "📂 Preparing deployment folder: $DEPLOY_DIR"

# CLEANUP
if [ -d "$DEPLOY_DIR" ]; then
    echo "🧹 Cleaning up existing deployment folder..."
    rm -rf "$DEPLOY_DIR"/*
fi

mkdir -p "$DEPLOY_DIR"
mkdir -p "$ASSETS_DIR"

# URL Decoding function
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# URL Encoding function (strictly for spaces to %20)
urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9/] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
}

# Copy logic
if [ -d "$TARGET_PATH" ]; then
    echo "📦 Copying directory content from $TARGET_PATH..."
    cp -R "$TARGET_PATH/"* "$DEPLOY_DIR/"
else
    echo "📄 Processing single file: $TARGET_PATH"
    FILENAME=$(basename "$TARGET_PATH")
    EXTENSION="${FILENAME##*.}"
    
    if [ "$EXTENSION" == "md" ]; then
        # For MD files, we create a copy we can modify
        cp "$TARGET_PATH" "$DEPLOY_DIR/index.md"
        
        echo "🔍 Searching for local resources in Markdown & HTML tags..."
        
        # Gather all unique local links. We use a set of regexes to find paths in common contexts.
        # This regex matches the path part of: [alt](path), ![alt](path), href="path", src="path"
        grep -oE '(!\[[^]]*\]\(([^)]+)\)|\[[^]]*\]\(([^)]+)\)|href="([^"]+)"|src="([^"]+)")' "$TARGET_PATH" | \
        sed -E 's/^!\[[^]]*\]\(([^)]+)\)$/\1/; s/^\[[^]]*\]\(([^)]+)\)$/\1/; s/^href="([^"]+)"$/\1/; s/^src="([^"]+)"$/\1/' | \
        sort | uniq | while read -r resource; do
            
            [[ -z "$resource" ]] && continue
            [[ "$resource" =~ ^(http|https|tel|mailto): ]] && continue
            
            # Remove URL parameters or anchors
            raw_res=$(echo "$resource" | cut -d'?' -f1 | cut -d'#' -f1)
            clean_res=$(urldecode "$raw_res")
            
            SOURCE_DIR=$(dirname "$TARGET_PATH")
            
            # Try different path resolutions
            ABS_RESOURCE_PATH=""
            if [ -f "$SOURCE_DIR/$clean_res" ]; then
                ABS_RESOURCE_PATH="$SOURCE_DIR/$clean_res"
            elif [ -f "$PROJECT_ROOT/$clean_res" ]; then
                ABS_RESOURCE_PATH="$PROJECT_ROOT/$clean_res"
            elif [[ "$clean_res" == ../* ]] && [ -f "$SOURCE_DIR/${clean_res#../}" ]; then
                ABS_RESOURCE_PATH="$SOURCE_DIR/${clean_res#../}"
            fi
            
            if [ ! -z "$ABS_RESOURCE_PATH" ]; then
                RES_FILENAME=$(basename "$clean_res")
                DEST_RES_PATH="assets/$RES_FILENAME"
                
                echo "   ➕ Copying resource: $clean_res -> $DEST_RES_PATH"
                cp "$ABS_RESOURCE_PATH" "$DEPLOY_DIR/$DEST_RES_PATH"
                
                # Update the path in the index.md file
                ENCODED_DEST_PATH=$(urlencode "$DEST_RES_PATH")
                
                # Escape the original resource string for safe use in sed
                # This handles dots, slashes, and spaces
                ESCAPED_MATCH=$(echo "$resource" | sed 's/[^^]/[&]/g; s/\^/\\^/g')
                
                # Replace the path wherever it appears exactly as it was found
                # We use a very specific sed to avoid double-replacing or breaking syntax
                sed -i '' "s|$ESCAPED_MATCH|$ENCODED_DEST_PATH|g" "$DEPLOY_DIR/index.md"
            fi
        done
    else
        cp "$TARGET_PATH" "$DEPLOY_DIR/"
    fi
fi

# Adding index.html (Docsify) if no index.html exists
if [ ! -f "$DEPLOY_DIR/index.html" ]; then
    echo "🎨 Adding Docsify index.html..."
    cat > "$DEPLOY_DIR/index.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>$SUBDOMAIN | Presentation</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify@4/lib/themes/vue.css">
  <style>
    :root { --theme-color: #007bff; }
    .markdown-section { max-width: 900px; margin: 0 auto; padding: 40px 15px; }
    img { max-width: 100%; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); margin-top: 10px;}
    .markdown-section h1 { color: #1e293b; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; }
    .markdown-section code { background: #f1f5f9; color: #0f172a; }
  </style>
</head>
<body>
  <div id="app">Loading...</div>
  <script>
    window.\$docsify = {
      name: '$SUBDOMAIN',
      loadSidebar: false,
      homepage: 'index.md',
      auto2top: true,
      executeScript: true,
      mergeNavbar: true,
    }
  </script>
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
  <!-- Mermaid support -->
  <script src="//cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
  <script src="//cdn.jsdelivr.net/npm/docsify-mermaid@latest/dist/docsify-mermaid.js"></script>
  <script>mermaid.initialize({ startOnLoad: true });</script>
</body>
</html>
EOF
fi

# Ensure project exists (idempotent creation via wrangler)
echo "🔍 Ensuring Cloudflare Pages project '$SUBDOMAIN' exists..."
npx wrangler pages project create "$SUBDOMAIN" --production-branch=main >/dev/null 2>&1 || true

# Deploy via Wrangler (Uses active Wrangler OAuth session)
echo "🚀 Deploying to Cloudflare Pages..."
CI=1 npx wrangler pages deploy "$DEPLOY_DIR" --project-name="$SUBDOMAIN" --commit-dirty=true

PAGES_URL="https://${SUBDOMAIN}.pages.dev"

echo ""
echo "=================================================="
echo "✅ Success! Your presentation is live at:"
echo "🔗 $PAGES_URL"
echo "=================================================="

