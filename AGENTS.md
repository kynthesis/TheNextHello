# Project workflow

- Build this game with Godot, focused on 2D and pixel art.
- Present the game as a nostalgic mobile social app from Asahi's account, with our own identity inspired by early social-network UI and Emily is Away. Use a 414×896 portrait app canvas that scales uniformly; no desktop sidebars or copied Facebook branding.
- Support one standard text size only; do not add text-size settings or alternate text-scale layouts.
- Keep exactly seven main sections: News Feed, Profile, Friends, Photos, Events, Messages and Requests. Profile is Asahi's account with statuses/comments/shares; Friends opens friends' profiles and their photos; Photos contains Asahi's own photos; Events holds story objectives; Messages contains DMs; Requests handles new friends. Settings is a header utility. Games, Work, Notes and Calendar remain internal save/story keys, not extra main sections.
- Asahi and Mizuki meet coincidentally through random game matchmaking, with no guild or mutual-friend introduction. Daichi appears only later.
- Keep UI minimal so players can focus on the story: no decorative wallpaper, oversized clock, duplicate dock, or texture controls. Use our own teal, warm paper and muted coral theme and custom pixel icons; do not copy Facebook branding or its blue theme.
- Use Emily is Away as a reference for intimate chat, awkward pauses, ordinary details and relationships changing over time. Keep Asahi's account viewpoint, consequential choices and the selected reply's meaning intact.
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
