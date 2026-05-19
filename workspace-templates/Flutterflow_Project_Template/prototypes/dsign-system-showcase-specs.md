# SPECIFICATION: Design System Showcase Generator

## GOAL

To generate a comprehensive, visually precise **Design System Showcase** page and an **ACCOMPANYING EXTERNAL CSS FILE** that serves as the single source of truth for all styles. The output must be highly functional, clean, and strictly adhere to the rules outlined below.

---

## 01. GLOBAL ARCHITECTURE & LAYOUT ("Newspaper Clean")

### Single Source of Truth (CSS)

- **ALL** styles MUST be placed in an external stylesheet (e.g. `style.css`).
- This file will be reused for subsequent prototypes.
- The showcase HTML file must only link to this stylesheet.
- Lightweight JavaScript (e.g. for copy-to-clipboard functionality) may be kept inline or inside a separate script file.

### Background & Aesthetics

- The body must use a neutral grey background (`#ECECEC` or `#F3F4F6`) to create a calm, structured Shanchi-style canvas.
- All typography defaults to pure black (`#000000`) for maximum contrast and high-end minimalist aesthetics.
- Avoid heavy shadows or card-based container wrapping for the meta-layout of the showcase page itself.

### Structure & Dividers

- Linear document flow.
- **CRITICAL:** Every single section and subsection MUST feature a minimalist horizontal divider (`<hr>`) directly beneath it to enforce the Shanchi layout grid.

### Headings

| Level | Style |
|-------|--------|
| **H1** | Large, bold (700) page-level title, pure black (`#000000`) |
| **H2** | Section titles (600), uppercase with increased letter spacing (tracking), pure black (`#000000`) |
| **H3** | Category labels (700), uppercase, pure black (`#000000`) without any colored accent lines or decorative indicators |

### Meta-typography

- Use **Plus Jakarta Sans** (imported from Google Fonts).
- **Text colors:** Monochromatic high contrast. Pure black (`#000000`) for headers, deep charcoal/black (`#111111`) for descriptions.
- Body text must use `-webkit-font-smoothing: antialiased`.

---

## 02. CRITICAL POLICY: "The Single Parameter Rule"

To ensure absolute technical transparency for developers:

| Rule | Description |
|------|-------------|
| **Rule** | EVERY technical parameter (Background, Border, Radius, Shadow, Typography, Padding, etc.) in the specifications MUST be placed on its own separate line. |
| **Prohibition** | Combining multiple parameters into a single line (e.g. `BG: #FFF / RAD: 12px`) is **STRICTLY PROHIBITED**. |
| **Legibility** | All technical metadata must use a minimum font size of **10px** with a line height of **1.5**. |

---

## 03. INTERACTIVITY & ANIMATION RULES

### No Decorative Animations

Information blocks, color swatches, and static texts **MUST remain static**.

### Interactive Elements

Only functional elements (Buttons, Inputs, Links) should demonstrate hover/active states (transitions for scale, opacity, background changes).

### Click-to-Copy

- Color hex codes **MUST** be copyable.
- Implement a lightweight vanilla JS script so that clicking a hex code copies it to the clipboard and displays visual feedback (e.g. a temporary `"Copied!"` toast or overlay).

---

## 04. COMPONENT INVENTORY (What to Build)

Generate the following sections in sequence. Each component must feature a visual preview followed by its technical metadata, strictly adhering to the **Single Parameter Rule**.

### Section 1: Design Tokens (Spacing, Radii, Shadows)

These are the fundamental system constants that define the visual rhythm and structure of the entire UI.

#### Spacing / Paddings

- **Standard:** 5 values (e.g. XS, S, M, L, XL or 4px, 8px, 16px, 24px, 32px).
- **Visualization:** Horizontal or vertical blocks of the corresponding size to visually demonstrate the spacing.
- **Metadata** under each token: Token name, value in pixels/rem (each on a new line).

#### Corner Radii (Radii)

- **Standard:** 4 values (e.g. S, M, L, Full or 4px, 8px, 12px, 16px).
- **Visualization:** Square containers sized **60×60 pixels** showcasing the respective corner radius.
- **Metadata** under each token: Token name, value in pixels.

#### Elevation / Shadows

- **Standard:** 4 values (e.g. Low, Medium, High, Floating).
- **Visualization:** White blocks placed on the grey background of the showcase page displaying the corresponding shadow effect.
- **Metadata** under each token: Token name, detailed CSS `box-shadow` properties (broken down by offset-x, offset-y, blur, color — each on a new line).

### Section 2: Color Palette (Colors)

Categorize into:

- Core
- Accent
- Backgrounds
- Typography
- Borders / Icons

#### Color Swatch Block

- Must have a fixed size of **80×80 pixels**.
- **Label below Swatch:** Descriptive name and a clickable Hex code.
- Clicking the Hex code must automatically copy it to the clipboard with a visual `"Copied!"` feedback.

### Section 3: Typography Matrix

- **Specimen Text:** The name of the text style (e.g. `"Page Title"`) rendered in its actual CSS styles.
- **Metadata below Specimen** (each on a new line):
  - Size: `[Value]`
  - Weight: `[Value]`
  - Color: `[Hex]`
  - Spacing: `[Value]` (optional)

### Section 4: Static UI Components (Cards, Containers & Badges)

#### Cards & Containers

Display all static card variants, container structures, or modular blocks that might exist in the app (e.g. product cards, profile panels, content lists, modal frameworks, etc.).

#### Badges

- Must adhere to a universal geometry: exactly **22px** height and **6px** corner radius.
- Group them into a dedicated container.

#### Metadata Placement

| Context | Placement |
|---------|-----------|
| Large blocks / cards | Integrate all technical parameters (Background, Border, Corner Radius, Shadow) **inside** the block itself as part of its content layout |
| Small elements (badges, labels) or compact cards | List all parameters **directly below** the element |

All parameters must strictly adhere to the **Single Parameter Rule** (each on a new line).

### Section 5: Interactive Elements (Buttons & Links)

- Wrap each interactive specimen in a white `.specimen-card` container to isolate its visual footprint against the grey background.
- Demonstrate active states and transitions on hover.
- **Metadata** below each item must list on separate lines:
  - Static Geometry (BG, Border, Radius, Padding)
  - Content Style
  - Hover / Active interaction behaviors

### Section 6: Forms & Inputs

**Include:**

- Text Field
- Search Bar
- Select Dropdown
- Toggle / Switch
- Radio elements

**Metadata** below each element must list on separate lines:

- Geometry (Height, Radius, Padding)
- Default Border vs. Focus Border
- Typography styles
- Component-specific dimensions (e.g. Track BG, Knob BG, and Sizing for toggles)

---

## 05. EXPECTED OUTPUTS

The generator must output exactly **two files**:

| File | Description |
|------|-------------|
| `style.css` | A highly organized stylesheet featuring CSS variables (custom properties) for design tokens and reusable utility/component classes |
| `index.html` | A semantic, clean HTML showcase page that imports `style.css` and includes lightweight JS for the click-to-copy interaction |
