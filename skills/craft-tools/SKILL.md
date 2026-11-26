---
name: craft-tools
version: 1.0.0
summary: >-
  Drive FigCraft, FilmCraft, AniCraft, EffectCraft, and VectorCraft from an AI
  agent on macOS, Windows, or Linux. Inspect, edit, animate, render, and export
  real projects through Antigravity MCP or the apps' CLIs.
description: >-
  Drive ArtCraft's creative apps from an AI agent on macOS, Windows, or Linux:
  FigCraft for interface design, FilmCraft for video editing, AniCraft for 2D
  animation, EffectCraft for motion graphics, and VectorCraft for vector
  illustration. Works through Antigravity MCP or through the apps' command-line
  tools in Claude Code, Cursor, Codex, Gemini CLI, or any shell-capable agent.
  Use for .figcraft, .fcproj, .anicraft, .ecproj, or .vectorcraft files, or for
  design, video, animation, motion-graphics, and vector-illustration work.
tags:
  - artcraft
  - figcraft
  - filmcraft
  - anicraft
  - effectcraft
  - vectorcraft
  - mcp
  - antigravity
  - claude-code
  - cursor
  - codex
  - gemini-cli
  - macos
  - windows
  - linux
keywords:
  - motion graphics
  - vector illustration
  - video editing
  - 2D animation
  - creative automation
  - design automation
use_cases:
  - Animate a vector poster
  - Export a video cut
  - Produce a looping GIF
  - Export print-ready vector art
  - Inspect a creative project before editing
  - Batch-render previews
---

# Craft Tools

Five professional creative apps, one workflow for agents.

| App | What it does | Native file |
| --- | --- | --- |
| **FigCraft** | Interface design, frames, components, prototypes | `.figcraft` |
| **FilmCraft** | Non-linear video editing, colour, audio, export | `.fcproj` |
| **AniCraft** | 2D animation, timeline, tweens, symbols | `.anicraft` |
| **EffectCraft** | Motion graphics, compositing, effects | `.ecproj` |
| **VectorCraft** | Vector illustration, paths, artboards, print export | `.vectorcraft` |

The apps ship macOS, Windows, and Linux builds. The CLI path works on all three.
The published Antigravity plugin is macOS-only for now.

## Two ways to work

| Path | Works in | Platforms | Tools |
| --- | --- | --- | --- |
| **CLI** | Claude Code, Cursor, Codex, Gemini CLI, Antigravity, any agent with shell access | macOS, Windows, Linux | `figcraft-cli`, `filmcraft-cli`, `anicraft-cli`, `effectcraft-cli`, `vectorcraft-cli` |
| **MCP** | Antigravity with the Craft Tools plugin | macOS (current plugin) | `craft-tools_<server>_<tool>` |

Prefer the CLI on Windows and Linux. Prefer MCP on macOS when the plugin is
installed. Both drive the same apps.

## Start here

1. Probe the installed CLIs:

   macOS / Linux:

   ```sh
   sh scripts/find-craft-clis.sh
   ```

   Windows PowerShell:

   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts\find-craft-clis.ps1
   ```

   The probe prints each CLI path, or `missing`.

2. Inspect before editing:

   - CLI: `<cli> info FILE`, `<cli> inspect`, `<cli> commands`.
   - MCP: `inspect_document`, `get_project` / `get_comp`, `anicraft_document`.

3. Discover commands instead of guessing. Run `<cli> commands` and
   `<cli> <command> --help`. CLI flags differ between app versions and
   platforms; `--help` is the source of truth.

## Platform notes

- **macOS**: the CLIs live in the app bundle, `~/.local/bin`, or
  `~/.local/share/<app>-cli`.
- **Windows**: MSI installers put the CLI next to the app under
  `%LOCALAPPDATA%\Programs\ArtCraft\<App>\`, usually as `<app>-cli.exe`. It is
  not on `PATH` by default. Portable ZIPs keep it beside the app.
- **Linux**: deb/rpm packages install `/usr/bin/<app>-cli`; tarballs go to
  `~/.local/bin`; some AppImages bundle the CLI and run it with `cli`, for
  example `./FigCraft.AppImage cli --help`.
- **FreeBSD**: CLI tarballs are available for some apps; use the CLI path.

See `references/platform-paths.md` for the per-app table.

## Golden rules

1. **Inspect first.** Read the document, comp, scene, layer, or selection before
   editing. Never guess layer ids, object ids, or property paths.
2. **Use the app's command registry.** Every menu action is a command. Discover
   it, then run it with documented params. Do not script the UI unless there is
   no command for the job.
3. **Confirm destructive actions.** Deleting layers, replacing files,
   overwriting exports, or discarding unsaved work needs the user's approval.
4. **Save before exporting.** Use a new path when the user has not supplied one.
5. **Verify visually.** Render a preview frame, contact sheet, or poster after a
   visual change, then report the exact files and dimensions.
6. **Stay local.** Project and media files stay on the user's computer. Do not
   upload them anywhere unless the user explicitly asks.

## Playbooks

| Goal | Read |
| --- | --- |
| Vector poster → animated motion piece | `references/workflows.md` |
| Brand/design system → UI screens | `references/workflows.md` |
| Storyboard → looping 2D animation | `references/workflows.md` |
| Video cut, grade, mix, export | `references/workflows.md` |
| Vector art → print/social exports | `references/workflows.md` |
| CLI recipes and OS paths | `references/cli-recipes.md` |
| Per-app CLI paths by OS | `references/platform-paths.md` |
| Antigravity, Claude, Cursor, Codex, Gemini setup | `references/agent-setup.md` |
| Errors and missing tools | `references/troubleshooting.md` |

## Limitations

- The desktop apps and CLIs must be installed. The probe reports what is
  missing.
- The published Antigravity plugin is macOS-only. On Windows and Linux, use the
  CLI path; an MCP server can be configured manually if needed.
- If your Linux AppImage bundles the CLI, prefix commands with `cli` (for
  example `./FigCraft.AppImage cli --help`); otherwise use the deb/rpm/tarball
  build.
- Some app features are UI-only. In CLI/headless mode, prefer engine commands
  and exports; use a live MCP bridge when the app supports one.
- Rendering is CPU-bound in headless mode unless the app's live GPU bridge is
  used.
