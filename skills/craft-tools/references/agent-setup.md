# Agent setup

Craft Tools works in two ways. Pick the path that matches the agent and the OS.

## Platform support

| OS | CLI path | Antigravity MCP path |
| --- | --- | --- |
| macOS | Yes | Yes, with the published Craft Tools plugin |
| Windows 10/11 | Yes | Use the CLI; the plugin is macOS-only for now |
| Linux | Yes | Use the CLI; the plugin is macOS-only for now |
| FreeBSD | CLI tarballs for some apps | Use the CLI |

## Antigravity (MCP, macOS)

1. Install the Craft Tools plugin:

   ```sh
   agy plugin install https://github.com/mahendartea/craft-tools
   agy plugin list
   ```

2. Restart the Antigravity session. In an interactive session, `/mcp` shows the
   five servers: `figcraft`, `filmcraft`, `anicraft`, `effectcraft`,
   `vectorcraft`.

3. The tools are namespaced as `craft-tools_<server>_<tool>`, for example
   `craft-tools_vectorcraft_inspect_document`.

4. Headless `agy -p` auto-denies MCP calls unless a permission allow-rule
   exists. Use an interactive session or add the rule under
   `permissions.allow` in Antigravity settings.

5. Live mode is optional:

   ```sh
   figcraft-live
   filmcraft-live
   effectcraft-live
   vectorcraft-live
   ```

   Reconnect the MCP server after starting a live app. AniCraft is headless.

## Claude Code, Cursor, Codex, Gemini CLI (CLI, all platforms)

These agents do not need MCP. They can run the app CLIs with shell commands.

macOS / Linux:

```sh
sh scripts/find-craft-clis.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\find-craft-clis.ps1
```

Use the printed paths, or add the CLI folder to `PATH`. Then use the recipes in
`references/cli-recipes.md`.

This path is agent-agnostic and OS-agnostic: any agent with shell access can use
it.

## Requirements

| Requirement | Notes |
| --- | --- |
| macOS 11+, Windows 10/11, or Linux | 64-bit x86 or ARM builds |
| The five ArtCraft apps | FigCraft, FilmCraft, AniCraft, EffectCraft, VectorCraft |
| App CLIs | Bundled with the apps; the probe finds them |
| Antigravity plugin (MCP path only) | macOS only for the published plugin |

## What the probe reports

```text
platform=macOS
figcraft=/Users/you/.local/bin/figcraft-cli
filmcraft=missing
...
```

`missing` means the app is not installed, the CLI is somewhere unusual, or the
path is not executable. Set the matching `*_CLI` environment variable to point
at it, or install the app.

## Windows notes

- MSI installs put the CLI under
  `%LOCALAPPDATA%\Programs\ArtCraft\<App>\<app>-cli.exe`. It is not on `PATH`.
- Portable ZIPs keep the CLI beside the app.
- Use PowerShell paths with `&` when the path contains spaces:

  ```powershell
  & "$env:LOCALAPPDATA\Programs\ArtCraft\VectorCraft\vectorcraft-cli.exe" --help
  ```

## Linux notes

- deb/rpm installs use `/usr/bin/<app>-cli`.
- Some AppImages bundle the CLI. Try `./App.AppImage cli --help`; if there is no
  `cli` subcommand, use the deb/rpm/tarball build.
- Flatpak is sandboxed; use the deb/rpm/tarball build for shell automation.

## Notes

- The MCP plugin and the CLIs are two interfaces to the same apps. Use one; they
  do not conflict.
- The plugin is Antigravity-specific and currently macOS-only. Other MCP clients
  can be configured with the same CLI wrappers if needed, but the CLI path is
  simpler and more portable.
- No API keys are needed. Everything runs locally.
