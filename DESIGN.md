# Design

Riverbed = skin over FreshRSS's `base-theme/frss.css` structure. Product register:
dense, familiar chrome; the article page is the one "brand" surface. All colors are
declared once in `_tokens.css` via `light-dark()`; `color-scheme` is driven by
FreshRSS's per-user darkMode setting (`html.darkMode_auto`).

## Color

| Token | Light | Dark | Role |
|---|---|---|---|
| `--rb-bg` | `#fffff8` | `#08090a` | canvas (Tufte warm white / Linear near-black) |
| `--rb-surface` | `#f7f7f2` | `#0f1011` | sidebar, panels, headers |
| `--rb-surface-2` | `#ffffff` | `#191a1b` | elevated: dropdowns, slider, cards, inputs |
| `--rb-hover` | `#f1f1ea` | `#1f2023` | hover fills |
| `--rb-border` | `#e5e7eb` | `#23252a` | standard borders |
| `--rb-hairline` | `rgba(17,17,17,.08)` | `rgba(255,255,255,.06)` | subtle separators |
| `--rb-text` | `#111111` | `#f7f8f8` | primary text |
| `--rb-text-article` | `#111111` | `#d0d6e0` | article body (~8.9:1 dark) |
| `--rb-text-2` | `#6b7280` | `#8a8f98` | secondary/meta |
| `--rb-text-3` | `#697080` | `#7d838d` | tertiary/meta (AA at 11–12px) |
| `--rb-accent` | `#5e6ad2` | `#5e6ad2` | fills, borders, focus rings |
| `--rb-accent-text` | `#5e6ad2` | `#828fff` | links/text on canvas (AA in dark) |

Dark elevation = lighter surface, never shadow (shadow tokens collapse to
transparent in dark). Unread/read state never relies on color alone.

## Typography

- UI: `InterVariable` → system + CJK sans stack. Chrome sits at 13px
  (`--rb-ui`), meta at 12px, scale 11–32 fixed rem steps.
- Article: `Newsreader` (variable, opsz) → Spectral/Charter/Georgia + CJK serif
  stack. Body 18px desktop / 16.5px mobile, line-height 1.6 (CJK-friendly),
  headings 1.15–1.25, paragraph spacing not indent, `text-wrap: pretty`.
- Measure: `content_thin` 58ch, `content_medium` 66ch (default, ideal),
  `content_large` 80ch, `no_limit` unchanged.
- Mono: `ui-monospace` stack for code; tabular-nums on unread counts.
- Latin webfonts carry `unicode-range` so CJK text never waits on them.

## Space, shape, motion

- Spacing on the 4/8 grid: 4/8/12/16/24/32/48 (`--rb-space-*`).
- Radius: 6px controls, 12px overlays/cards, pill tags.
- Motion: 100–200ms, `cubic-bezier(0, 0, 0.2, 1)` (ease-out), transform/opacity
  only, no bounce; `prefers-reduced-motion` zeroes everything incl. core drawer.
- Z-scale: dropdown 10 < sticky 20 < drawer/backdrop 100 (core) < slider 1000 <
  notification 1100 (align with frss.css's existing values; never 9999).

## Component notes

- Timeline row: favicon + title (weight = unread) + relative time + 2-line
  excerpt; unread dot in the gutter; read rows dim to `--rb-text-2`; actions
  reveal on hover via opacity (focusable always; always visible on touch).
- Sidebar tree: 13px, unread badges right-aligned tabular; active feed gets
  accent text + `--rb-hover` fill, not a heavy pill.
- Buttons: quiet by default (transparent → hover fill); `.btn-important` is the
  only filled accent control on a screen.
- Dropdowns/slider: `--rb-surface-2`, 12px radius, hairline border, no pointer
  arrow (core's `::after` triangle removed).
- Article header: title 24px serif, meta row 12px UI sans; tags as quiet pills.
