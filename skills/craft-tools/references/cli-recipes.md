# CLI recipes

The app CLIs are the portable path: they work in Claude Code, Cursor, Codex,
Gemini CLI, Antigravity, or any agent that can run shell commands.

Run the probe first:

- macOS / Linux: `sh scripts/find-craft-clis.sh`
- Windows: `powershell -ExecutionPolicy Bypass -File scripts\find-craft-clis.ps1`

Paths by OS are in `references/platform-paths.md`. The examples below use POSIX
shell syntax. On Windows, prefix PowerShell paths with `&`:

```powershell
& "$env:LOCALAPPDATA\Programs\ArtCraft\VectorCraft\vectorcraft-cli.exe" --help
```

Flags change between app versions: `<cli> <command> --help` is the source of
truth. If your Linux AppImage bundles the CLI, add `cli` before the arguments
(for example FigCraft):

```sh
./FigCraft.AppImage cli --help
```

## FigCraft

```sh
figcraft-cli info design.figcraft
figcraft-cli commands
figcraft-cli run design.figcraft script.json
figcraft-cli render --help
figcraft-cli export --help
```

FigCraft opens `.figcraft`, `.penpot`, `.fig`, `.sketch`, `.svg`, and image
files. Use `info` to see pages, frames, styles, variables, and what an import
left out. On Linux AppImage: `./FigCraft.AppImage cli ...`.

## FilmCraft

```sh
filmcraft-cli --project project.fcproj inspect
filmcraft-cli --project project.fcproj commands
filmcraft-cli --project project.fcproj render --seconds 2 --out frame.png
filmcraft-cli --project project.fcproj export out.mp4 --format h264
```

Windows:

```powershell
& "$env:LOCALAPPDATA\Programs\ArtCraft\FilmCraft\filmcraft-cli.exe" --project project.fcproj inspect
```

`export` waits for the file unless `--queue` is used. `--range` accepts
`entire`, `inOut`, `workArea`, or seconds. `--no-audio` drops the audio.

## AniCraft

```sh
anicraft-cli info movie.anicraft
anicraft-cli render movie.anicraft --out frame.png --frame 12
anicraft-cli render-seq movie.anicraft --out-dir frames --from 1 --to 24
anicraft-cli gif movie.anicraft --out anim.gif --from 1 --to 24
anicraft-cli run movie.anicraft script.json
anicraft-cli commands
```

AniCraft CLI frames are **1-based** (MCP frames are 0-based). AniCraft is
headless only.

## EffectCraft

```sh
effectcraft-cli --project project.ecproj info
effectcraft-cli --project project.ecproj commands
effectcraft-cli --project project.ecproj render-frame --time 2 --out frame.png
effectcraft-cli --project project.ecproj render --out out.mp4 --format h264
effectcraft-cli --project project.ecproj exec command.id '{"key":"value"}'
```

Windows:

```powershell
& "$env:LOCALAPPDATA\Programs\ArtCraft\EffectCraft\effectcraft-cli.exe" --project project.ecproj info
```

Times are seconds. `render --queue` adds to the render queue instead of waiting.
Start the app with `effectcraft --control 9877` for a live bridge.

## VectorCraft

```sh
vectorcraft-cli info art.vectorcraft
vectorcraft-cli convert art.vectorcraft art.pdf
vectorcraft-cli run --in art.vectorcraft --export art.png
vectorcraft-cli mcp --headless
```

Windows:

```powershell
& "$env:LOCALAPPDATA\Programs\ArtCraft\VectorCraft\vectorcraft-cli.exe" info art.vectorcraft
```

`convert` picks the output format from the extension (`.pdf`, `.svg`, `.png`,
`.jpg`, `.tiff`, `.psd`, `.dxf`, and more). `run` accepts `--cmd ID 'JSON'`
steps and `--export FILE`. Start the app with `vectorcraft --control 7979` for a
live MCP bridge.

## Shared patterns

- Inspect: `info` / `inspect` / `commands`.
- Edit: `run` a JSON command script, or `exec` one command.
- Preview: render one frame before exporting.
- Export: choose the format from the output extension or `--format`.
- Verify: check the file exists, then report its dimensions and size.
- Windows: quote paths containing spaces and use `&` in PowerShell.
- Linux AppImage: if the build bundles the CLI, insert `cli` after the AppImage path; otherwise use deb/rpm/tarball.
