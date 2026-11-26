# Troubleshooting

## A CLI is missing

Run the probe for the OS:

macOS / Linux:

```sh
sh scripts/find-craft-clis.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\find-craft-clis.ps1
```

Set the matching environment variable to the real path:

```sh
FIGCRAFT_CLI=/path/to/figcraft-cli
FILMCRAFT_CLI=/path/to/filmcraft-cli
ANICRAFT_CLI=/path/to/anicraft-cli
EFFECTCRAFT_CLI=/path/to/effectcraft-cli
VECTORCRAFT_CLI=/path/to/vectorcraft-cli
```

Common locations are in `references/platform-paths.md`.

## Windows: the CLI is not found

- MSI installs put `<app>-cli.exe` under
  `%LOCALAPPDATA%\Programs\ArtCraft\<App>\`. It is not on `PATH`.
- Portable ZIPs keep the CLI beside the app.
- In PowerShell, call the full path with `&`:

  ```powershell
  & "$env:LOCALAPPDATA\Programs\ArtCraft\VectorCraft\vectorcraft-cli.exe" --help
  ```

- If PowerShell blocks the probe script:

  ```powershell
  powershell -ExecutionPolicy Bypass -File scripts\find-craft-clis.ps1
  ```

## Linux: the CLI is not found

- deb/rpm installs use `/usr/bin/<app>-cli`.
- Tarballs usually install to `~/.local/bin`.
- Some AppImages bundle the CLI. If yours does, run it with the `cli`
  subcommand:

  ```sh
  ./FigCraft.AppImage cli --help
  ```

  If there is no `cli` subcommand, use the deb/rpm/tarball build.

- Flatpak is sandboxed. Use the deb/rpm/tarball build for shell automation.

## Antigravity MCP tools are missing

The published plugin is macOS-only.

1. `agy plugin list` — is `craft-tools` enabled?
2. Restart the session.
3. `/mcp` in an interactive session — are the five servers connected?
4. Check the plugin is installed in `~/.gemini/config/plugins/craft-tools`.
5. Reinstall it if the manifest or skill changed.

On Windows or Linux, use the CLI path instead.

## Headless `agy -p` refuses MCP tools

MCP calls need permission. Add an allow rule under `permissions.allow` in
Antigravity settings, or run a read-only test with
`--dangerously-skip-permissions` (only when you control the prompt).

## A transparent PNG shows a white box

The image was exported without alpha. Re-export with:

```text
background: "transparent"
```

Check with:

```sh
sips -g hasAlpha image.png        # macOS
```

On Linux, use `file` or an image tool that reports the alpha channel. On
Windows, check the PNG properties in an image editor.

## Live mode will not attach

| App | Command | Port |
| --- | --- | --- |
| FigCraft | `figcraft-live` | 8765 |
| FilmCraft | `filmcraft-live` | 9876 |
| EffectCraft | `effectcraft-live` | 9877 |
| VectorCraft | `vectorcraft-live` | 7979 |

Start the app first, wait for its window, then restart/reconnect the MCP server.
AniCraft has no live bridge.

## Fonts look wrong

The app falls back to the closest installed style. Use a style the family
actually has (for example `SemiBold` instead of `Bold`), or check the app's font
list. Re-export after fixing.

## Export warnings

Read the `warnings` array. Common causes: missing fonts, unsupported effects,
transparent pixels in JPEG, or art extending outside the artboard. Fix the
document or choose a format that supports the feature.

## The agent wants to use a GUI

Headless CLIs cover engine commands and exports. UI-only actions need the app's
live bridge and its `ui_*` tools. Do not fake a UI action in headless mode.

## The app is not available for this OS

The five apps publish macOS, Windows, and Linux builds. Some also publish
FreeBSD CLI tarballs. Install the build for the OS, then rerun the probe. There
is no supported GUI on FreeBSD.
