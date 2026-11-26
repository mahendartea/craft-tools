# Platform paths

The five apps ship macOS, Windows, and Linux builds. Installers differ, so use
the probe first:

- macOS / Linux: `sh scripts/find-craft-clis.sh`
- Windows PowerShell: `powershell -ExecutionPolicy Bypass -File scripts\find-craft-clis.ps1`

If a path differs, set the matching variable: `FIGCRAFT_CLI`, `FILMCRAFT_CLI`,
`ANICRAFT_CLI`, `EFFECTCRAFT_CLI`, `VECTORCRAFT_CLI`.

## Default locations

| App | macOS | Windows (per-user MSI) | Linux |
| --- | --- | --- | --- |
| **FigCraft** | `~/.local/bin/figcraft-cli` | `%LOCALAPPDATA%\Programs\ArtCraft\FigCraft\figcraft-cli.exe` | `/usr/bin/figcraft-cli`; AppImage: `./FigCraft.AppImage cli` |
| **FilmCraft** | `~/.local/share/filmcraft-cli/filmcraft-cli` or `~/.local/bin/filmcraft-cli` | `%LOCALAPPDATA%\Programs\ArtCraft\FilmCraft\filmcraft-cli.exe` | `/usr/bin/filmcraft-cli`; tarball: `~/.local/bin/filmcraft-cli` |
| **AniCraft** | `/Applications/AniCraft.app/Contents/MacOS/anicraft-cli` or `~/.local/bin/anicraft-cli` | `%LOCALAPPDATA%\Programs\ArtCraft\AniCraft\anicraft-cli.exe` | `/usr/bin/anicraft-cli`; tarball/AppImage: check the app folder |
| **EffectCraft** | `~/.local/share/effectcraft-cli/effectcraft-cli` or `~/.local/bin/effectcraft-cli` | `%LOCALAPPDATA%\Programs\ArtCraft\EffectCraft\effectcraft-cli.exe` | `/usr/bin/effectcraft-cli` |
| **VectorCraft** | `~/.local/share/vectorcraft-cli/vectorcraft-cli` or `~/.local/bin/vectorcraft-cli` | `%LOCALAPPDATA%\Programs\ArtCraft\VectorCraft\vectorcraft-cli.exe` | `/usr/bin/vectorcraft-cli` |

## Windows notes

- The default MSI install is per-user, without an administrator prompt.
- "Everyone on this computer" installs under `%ProgramFiles%\ArtCraft\<App>\`
  (or `%ProgramFiles(x86)%` for 32-bit builds).
- Portable ZIPs keep `<app>-cli.exe` beside the app; add that folder to `PATH`
  or point the `*_CLI` variable at the `.exe`.
- The CLI is not on `PATH` by default after an MSI install.

## Linux notes

- deb/rpm packages install `/usr/bin/<app>-cli`.
- Tarball installers usually put the app and CLI in `~/.local/bin`.
- Some AppImages bundle the CLI. Use the `cli` subcommand where the build
  supports it, for example:

  ```sh
  ./FigCraft.AppImage cli --help
  ```

  The exact AppImage name follows the release asset, for example
  `figcraft-0.18.1-linux-x86_64.AppImage`. If your AppImage has no `cli`
  subcommand, use the deb/rpm/tarball build.

- Flatpak builds are sandboxed. Run the CLI inside the Flatpak sandbox or use the
  tarball/deb/rpm build when shell automation is needed.

## FreeBSD

Some apps publish FreeBSD tarballs with a CLI in `bin/`. Check the extracted
folder and use the CLI path; GUI support is not guaranteed.

## Antigravity MCP

The published Craft Tools Antigravity plugin is macOS-only: its `mcp_config.json`
uses macOS wrapper paths. On Windows and Linux, use the CLI path. You can also
configure your own MCP server entries pointing at the OS-specific CLI, but that
setup is outside this package.
