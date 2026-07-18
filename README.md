# Riverbed

A theme for [FreshRSS](https://github.com/FreshRSS/FreshRSS) that treats reading as the point.

FreshRSS is where your feeds live. Riverbed is what makes sitting down with them
feel less like clearing an inbox and more like reading. The timeline stays quiet
so you can triage fast. Open an article and the page is set like a book — one
serif column, a comfortable width, a comfortable size — so you actually read it.

Made for daily reading in English and Chinese, on the desktop and the phone, in
light and dark.

**Timeline — light**

![Timeline, light](docs/list-light.png)

**Timeline — dark**

![Timeline, dark](docs/list-dark.png)

**Article view**

![Article view, light](docs/article-light.png)

## What changes

- **The article reads like a page, not a feed.** Body text is set in a serif
  (Newsreader) at a book-like size on a measured column, so long pieces stop
  feeling like a wall of screen.
- **A calm timeline.** Quiet chrome, monochrome icons, unread shown by a dot and
  a little weight instead of loud color. Your eye lands on the writing, not the UI.
- **Dark mode that follows you.** It rides FreshRSS's own dark-mode setting and
  your system preference — warm white by day, near-black at night. Nothing extra
  to toggle.
- **Chinese and English sit well together.** Mixed 中文 and English text gets the
  small breathing space it needs, and Chinese renders in your system's serif with
  no loading delay.
- **Built for the phone too.** Big touch targets, safe-area padding, and the
  swipe gestures you already use (works with the TouchControl extension).
- **Easy on the eyes, on purpose.** Every text-on-background pair meets WCAG AA
  contrast in both light and dark, and animation respects "reduce motion."

## Install

You already run FreshRSS, so this is one clone and one command. The theme is the
`Riverbed/` folder in this repo; `deploy.sh` copies it into place.

```sh
git clone https://github.com/wilbeibi/freshrss-riverbed.git
cd freshrss-riverbed
DEST=/path/to/FreshRSS/p/themes/Riverbed ./deploy.sh
```

Then pick **Riverbed** in Settings → Display → Theme.

**Docker / Podman.** The image's `p/themes/` isn't persisted, so bind-mount a
host directory read-only and point `DEST` at it:

```
Volume=/host/freshrss/themes/Riverbed:/var/www/FreshRSS/p/themes/Riverbed:ro
```

Restart the container once, then `DEST=/host/freshrss/themes/Riverbed ./deploy.sh`.
Later CSS updates need no restart.

**No shell?** Copy the `Riverbed/` folder into `p/themes/` directly. It works —
just hard-refresh once after a future update to clear the browser cache.

### Recommended settings

- Automatic dark mode: **Auto**
- Content width: **Medium** (the ideal reading measure; pick **Thin** if you read mostly Chinese)
- Website: **Icon and name**

## Good to know

- FreshRSS's dark mode has two states: follow the system (**Auto**) or force
  light (**No**). There's no "always dark while my system is light" — set your
  system or browser to dark for that.
- Login and registration pages use the **default user's** theme, so they only
  show Riverbed once the default user has selected it.
- FreshRSS updates can move things under the hood. Riverbed fails soft: anything
  it hasn't styled falls back to plain FreshRSS, never a broken page.

## Under the hood

For the curious, or anyone extending it: the design rationale — color tokens,
type scale, the CJK-aware typesetting — lives in [DESIGN.md](DESIGN.md).

`deploy.sh` bundles the theme's source partials into a single `riverbed.css`
because FreshRSS serves theme assets with a 30-day cache and only busts the one
metadata-listed file; bundling makes every update land right away.

## Licensing

Theme CSS: MIT. Bundled fonts: Inter (© The Inter Project Authors) and
Newsreader (© The Newsreader Project Authors), both SIL OFL 1.1 — see
`Riverbed/fonts/OFL.txt`.
