# Project workflow

- Build this game with Godot, focused on 2D and pixel art.
- Present the game entirely through Asahi's personal phone. Keep all visible UI inside the phone, use his point of view for personal notes/account information, and avoid external titles, instructions, or character dossiers.
- Support one standard text size only; do not add text-size settings or alternate text-scale layouts.
- Prefer CLI tools for all development and asset work. Use Swallowtail (`godot-mcp-go`) first for Godot editor inspection, automation, validation, and debugging; use the Godot CLI for imports, headless checks, and exports. Use Aseprite's batch CLI for supported sprite operations.
- Use MCP, including `hi-godot/godot-ai`, only when CLI tools cannot fulfill the task. Explain the missing CLI capability when switching to MCP.
- For Aseprite work, use the Aseprite CLI first. Use `aseprite-ai-artist` or `diivi/aseprite-mcp` only when the CLI cannot satisfy the task.
- The installed Swallowtail CLI is at `C:/Users/Khoa/.codex/tools/godot-integrations/swallowtail_1.2.0_windows_amd64/swallowtail.exe`. Pass `--project C:/Users/Khoa/Dev/TheNextHello` when the current directory is elsewhere.
- Godot is available as `godot`; the installed engine version is 4.7.2.
- Use the Steam version of Aseprite at `C:/Program Files (x86)/Steam/steamapps/common/Aseprite/Aseprite.exe`. Use `--batch` for noninteractive work.

# Token efficiency

- Read relevant files before editing; reuse unchanged content already read.
- Reason thoroughly and report results concisely. Omit filler, flattery, and repetitive summaries.
- Avoid reading files larger than 100 KB unless the task requires them.
- Verify APIs, versions, flags, package names, and commit IDs using code or documentation.
- Use `cto measure` for Claude-context estimates. Preview `cto prune` or `cto compress` with `--dry-run` before applying changes; preserve project instructions and CLI-first preferences.

# Commit messages

- Always provide commit messages in the format `vMAJOR.MINOR.PATCH: message`.
- Check `git log` before choosing the next version; do not guess or reuse a version.
- Choose the increment to match the change: patch for fixes and small polish, minor for substantial features or visual updates, major for a major milestone or breaking overhaul. During pre-1.0 development, substantial additions normally increment the minor version.
