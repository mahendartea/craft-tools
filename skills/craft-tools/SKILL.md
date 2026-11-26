---
name: craft-tools
description: >-
  Work with ArtCraft's creative apps through their MCP servers: FigCraft for
  interface design, FilmCraft for video editing, AniCraft for 2D animation, and
  EffectCraft for motion graphics. Use when the user asks to inspect, edit,
  animate, render, or export a .figcraft, .fcproj, .anicraft, or .ecproj file,
  or asks for design, video, animation, or motion-graphics work.
---

# Craft Tools

Four local MCP servers are available. Antigravity namespaces their tools as
`craft-tools_<server>_<tool>`.

| Server | Use it for | First inspection call |
| --- | --- | --- |
| `figcraft` | UI design, frames, components, prototyping | `inspect_document` |
| `filmcraft` | Video editing, colour, audio, export | `doc_inspect` / `project_inspect` |
| `anicraft` | 2D animation, tweens, timeline, GIF/video | `anicraft_document` |
| `effectcraft` | Motion graphics, effects, compositing | `get_project` / `get_comp` |

## Working rules

1. Inspect before editing: read the document/project and the current
   comp/scene/layer. Never guess layer ids or property paths.
2. Prefer the app's command registry over free-form scripting. Discover
   commands first (`anicraft_commands`, `command_list`, `list_commands`) and
   use the documented ids and params.
3. Confirm before destructive actions: deleting layers, replacing a file,
   overwriting an export, or discarding unsaved work.
4. Save to a new file when the user has not given an explicit output path.
5. After a visual change, render a preview frame or contact sheet to verify the
   result before exporting.
6. Report the exact files written and their dimensions/format.

## App notes

- **FigCraft** and **FilmCraft** attach to the running app when its control
  port is listening; otherwise they run headless.
- **AniCraft** is headless only. Save with `file.save`, then open the
  `.anicraft` file in the app to see it.
- **EffectCraft** supports a live bridge (`effectcraft-live`), which adds
  screenshot and `ui_*` tools. Without the bridge it renders on the CPU.
- Media/project files stay on this Mac. Do not upload them anywhere unless the
  user asks.
