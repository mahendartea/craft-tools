# Craft Tools for Antigravity

Bundles local [MCP](https://antigravity.google/docs/mcp) servers for the four
ArtCraft creative apps installed on this Mac:

| Server | App | What it does |
| --- | --- | --- |
| `figcraft` | FigCraft | Interface design, frames, components, prototypes |
| `filmcraft` | FilmCraft | Non-linear video editing, colour, audio, export |
| `anicraft` | AniCraft | 2D animation, timeline, tweens, GIF/video export |
| `effectcraft` | EffectCraft | Motion graphics, compositing, effects, render queue |

Antigravity namespaces each server's tools as
`craft-tools_<server>_<tool>` and loads the bundled `craft-tools` skill when a
creative task matches.

## Requirements

The four wrapper scripts must exist and be executable:

```sh
ls -l ~/.local/bin/figcraft-mcp ~/.local/bin/filmcraft-mcp \
      ~/.local/bin/anicraft-mcp ~/.local/bin/effectcraft-mcp
```

Each wrapper starts the app's own CLI/MCP server. AniCraft runs headless.
FigCraft, FilmCraft and EffectCraft automatically attach to the running app if
its control port is listening; otherwise they fall back to a headless engine.

## Live mode

```sh
figcraft-live       # control port 8765
filmcraft-live      # control port 9876
effectcraft-live    # control port 9877
```

After starting a live app, reconnect the plugin's MCP server (restart the
Antigravity session) so the bridge is used. AniCraft has no control server and
is always headless.

## Manual install

```sh
agy plugin validate --strict ~/Documents/Antigravity/plugins/craft-tools
agy plugin install ~/Documents/Antigravity/plugins/craft-tools
agy plugin list
```
