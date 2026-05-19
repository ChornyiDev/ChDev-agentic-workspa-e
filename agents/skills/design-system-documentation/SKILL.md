---
name: design-system-documentation
description: Generates high-fidelity, self-documenting UI Design Showcases (UI Kits) by analyzing an existing web application's CSS and component architecture. Use when the user wants to unify design standards, create a living style guide, or prepare documentation for developers. Triggers on requests like "create design showcase", "build UI kit", or "document design system".
---

# Design System Documentation Skill

This skill guides the creation of an interactive `Design_Showcase.html` file that serves as a technical bridge between design and development.

## Core Philosophy: Self-Documenting UI
The goal of a Design Showcase is not just to see the UI, but to *read* its technical parameters immediately. 
- **Real Anatomy**: Use real component structures from the app.
- **Embedded Specs**: Display CSS properties (Hex, Radius, Shadow, Padding) directly inside or adjacent to the component.
- **Developer First**: Focus on information density and technical accuracy over decorative presentation.

## Workflow

### 1. Style Discovery
Analyze the existing codebase (`index.css`, component files) to identify global tokens:
- **Colors**: Primary, Success, Warning, Danger, Neutrals (HEX required).
- **Typography**: Font families (e.g., Inter), Font sizes (H1-H4, Body), Weights.
- **Common Shapes**: `border-radius` values and `box-shadow` configurations.

### 2. Typography Specification
Document every text variant used in the app. For each sample:
- Show the visual example.
- List technical specs below: `Size`, `Weight`, `Color`, `Letter Spacing`, `Casing`.
- Include Secondary and Muted text variants found in cards.

### 3. Component Anatomy Library
For complex components (Cards, Alerts, Feed items):
- **Clone the Structure**: Reproduce the exact HTML/CSS structure of the real component.
- **Empty the Content**: Remove business data (names, prices) to show the skeleton.
- **Overlay Specs**: Write CSS properties directly inside the empty block.

### 4. Interactive Elements (Side-by-Side)
For smaller elements (Buttons, Inputs, Toggles):
- Show the interactive element on the left.
- Provide a detailed property list on the right.
- Include all states (Active, Idle, Hover-spec) if available.

### 5. Semantic & Status Badges
Group all status-related badges (Success, Warning, Danger, etc.):
- Show the visual badge.
- Explicitly list `Bg`, `Text`, and `Border` hex codes using a monospace font below.

## Showcase Structure Template
The output `Design_Showcase.html` should typically follow this order:
1. **Header**: Title and Global Font Name.
2. **01. Color Palette**: Visual grid with HEX codes.
3. **02. Typography**: Sequential list with technical metadata.
4. **03. UI Components Library**: Self-documenting real Blocks/Cards.
5. **04. Interactive Elements**: Buttons & Badges with side-by-side specs.
6. **05. Forms & Inputs**: Fields with side-by-side specs.

## Implementation Details
- Use **Vanilla CSS** and **Semantic HTML** for maximum portability.
- Ensure the showcase itself follows the project's design language.
- Use **Lucide Icons** if used in the project for visual consistency.
