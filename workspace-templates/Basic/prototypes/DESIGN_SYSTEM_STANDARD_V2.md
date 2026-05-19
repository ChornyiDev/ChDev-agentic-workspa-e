# DESIGN SYSTEM SHOWCASE STANDARD (V2)

## 01. Engineering Readability Policy (CRITICAL)
- **The Single Parameter Rule:** To ensure absolute technical transparency and zero-error replication, **EVERY technical parameter** (BG, BORDER, RADIUS, SHADOW, TYPO, PADDING, etc.) **MUST be placed on its own separate line**. 
- **Grouping Prohibited:** Combining multiple parameters into a single line (e.g., "BG: #FFF / RAD: 12px") is strictly prohibited for ALL elements (Typography, Containers, Badges, Buttons).
- **Legibility:** All technical metadata must use a minimum font size of **10px** with a line spacing of **1.5** for comfortable scanning.

## 02. Document Architecture (Layout)
The showcase must follow a "Newspaper Clean" aesthetic: high-contrast, linear, and lightweight.

- **Background:** Must use a subtle blue-grey tint (e.g., Slate 50 / `#F8FAFC`) to distinguish white surface elements.
- **Structure:** No wrapping containers, heavy shadows, or card-based sectioning for the meta-layout.
- **Flow:** Linear document flow using clear headings and horizontal rules (`<hr>`).
- **Dividers:** Minimalist horizontal separators to distinguish primary sections.
- **Headers:** 
  - `H1`: Large, bold (700), page-level title.
  - `H2`: Section titles (600), uppercase with tracking.
  - `H3`: Category labels (700), uppercase, black `#000` with a left primary-color accent bar.

## 02. Specification (Meta) Typography
To maintain a professional, academic feel:
- **Font Family:** `Plus Jakarta Sans` is the standard for documentation.
- **Weights:** 
  - Titles: Max `700`.
  - Content: `400` (Regular) with `-webkit-font-smoothing: antialiased`.
  - Sections: `600-700`.
- **Contrast:** High contrast (Pure Black `#000` for headers, Slate 700 `#475569` for descriptions).

## 03. Color Specification Requirements
- **Card Size:** Minimum width `130px`.
- **Card Content:** 
  - Top: Color preview block (height ~60-70px).
  - Bottom: Descriptive name and Hex code.
- **Interactions:**
  - **No Hover Animations:** Cards must remain static to serve as informational readouts.
  - **Click-to-Copy:** Hex codes must be copyable to the clipboard upon clicking the card or code block.
  - **Feedback:** Visual confirmation (Toast or "Copied" overlay) when a value is copied.
- **Categorization:** Colors must be divided into logical groups (Core, Accent, Backgrounds, Typography, Borders/Icons).

## 04. Animation Guidelines
Animations must be used only where they reflect real UI behavior:
- **Info Blocks:** Static information (codes, descriptions, swatches) **MUST NOT** have animations.
- **Interactive Controls:** Only functional elements (Buttons, Inputs, Nav items) should demonstrate their specific interaction states (Scale, Opacity transitions).

## 06. Typography Matrix Rules
To ensure developers can easily replicate the UI:
- **Specimen Text:** The name of the font style (e.g., "Page Title") must be rendered in that actual style.
- **Metadata:** Below each specimen, include a standardized readout: `Size / Weight / Color (Hex) / [Optional] Spacing`.
- **Contrast:** Ensure samples are shown against the standard document background (`#F8FAFC`).

## 07. UI Component Specification
For every interface component (Cards, Badges, Buttons):
- **Technical Checklist:** Documentation MUST explicitly list:
  1.  **Background:** Hex color.
  2.  **Border:** Thickness and Hex color.
  3.  **Corner Radius:** Value in `px`.
  4.  **Shadow/Elevation:** Specific token or CSS property.
  5.  **Hover/Active States:** Any changes in background, border, or shadow.
- **Presentation:** For small assets (like Badges), they must be grouped in a dedicated container with their specifications listed clearly below or beside them.
- **Badge Uniformity:** All semantic and status badges **MUST** adhere to a universal geometry:
  - **Height:** Standard height of **22px**.
  - **Radius:** Standard corner radius of **6px**.
- **Readability Standard:** To ensure technical transparency, every engineering parameter (BG, BORDER, RADIUS, SHADOW, TYPO, etc.) **MUST be placed on a separate line**. Grouping multiple parameters into a single line is strictly prohibited as it reduces legibility.

## 08. Interactive Elements Specification
For all interactive assets (Buttons, Icon buttons, Links):
- **Technical Checklist:** Documentation MUST explicitly list:
  1.  **Static Geometry:** BG, Border, Radius, Padding.
  2.  **Content Style:** Font size/weight/color, Icon size/color.
  3.  **Interaction (Hover):** Transition speed and changes in BG, Border, or Shadow.
- **Presentation:** Every interactive specimen **MUST** be wrapped in a white container (`.specimen-card`) to isolate its visual footprint.
- **Behavior:** The showcase item should demonstrate the actual hover effect specified in the meta-data.

## 09. Forms & Input Specification
For all form controls (Text fields, Search bars, Selects, Toggles):
- **Technical Checklist:** Documentation MUST explicitly list:
  1.  **Geometry:** Height, Radius, Padding (H/V).
  2.  **State Borders:** Default Border color vs. Focus/Active Border color.
  3.  **Typography Matrix:** Font Styles for Inputs, Labels, and Placeholders.
  4.  **Toggles/Radios:** Track BG, Knob BG, and Sizing.

## 10. Implementation Philosophy
- **Cleanliness:** Avoid visual noise, unnecessary gradients, or decorative elements.
- **Utility:** The showcase must be a tool for developers (quick copy, clear reading).
- **Separation:** Keep documentation logic (Meta UI) clearly separated from project-specific CSS variables.
