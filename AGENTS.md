# Project workflow

- Build this game with Godot, focused on 2D and pixel art.
- Present the game through Asahi's account on Noir, a flat nostalgic mobile social network with the familiar blue palette, multicolor icons and intimate chat. Use a 414×896 portrait app canvas that scales uniformly; no desktop sidebars.
- Set the story in Japan from October 2009 into spring 2010. Use distinct, natural 2009-style English chats; character birthdays must preserve the established opening ages. Read design/CHARACTERS.md and content/characters.json for voices and preferences.
- Author dialogue in content/dialogue/*.dialogue using the bundled Dialogue Manager. Keep stable IDs and read-only predicates; plot effects belong in content/story.json. Regenerate through tools/build_content.py and run tools/check.ps1.
- Use the humanizer skill when writing or revising story prose and character profiles.
- Support one standard text size only; do not add text-size settings or alternate text-scale layouts.
- Keep exactly seven main sections: News Feed, Profile, Friends, Photos, Events, Messages and Requests. Profile is Asahi's account with statuses/comments/shares; Friends opens friends' profiles and their photos; Photos contains Asahi's own photos; Events holds story objectives; Messages contains DMs; Requests handles new friends. Settings and Music are header utilities. All story conversations use Messages, either DMs or group chats. Removed Games/Work screens are migration aliases only; work and gaming remain story topics. Events is the only place for progress, objectives and next-action guidance. Never show mission banners or progress badges.
- Asahi and Mizuki meet coincidentally through random game matchmaking, with no guild or mutual-friend introduction. Daichi appears only later.
- Keep UI minimal so players can focus on the story: no decorative wallpaper, oversized clock, duplicate dock, or texture controls. Use the Noir wordmark, flat blue/pale gray-lilac fills, thin borders, multicolor icons, red message badges, white incoming/blue outgoing bubbles and compact feed actions. Avoid gradients, bevels and button shadows. Recreate old iOS keyboard clicks, send whoosh and incoming tri-tone through original synthesis. Use slow, uneven character typing with word/punctuation pauses; Finish typing must remain available.
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
