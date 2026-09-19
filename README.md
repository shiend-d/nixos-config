# nixos-config

![NixOS](https://img.shields.io/badge/NixOS-Unstable-blue?logo=nixos&logoColor=white)
![Nix Flakes](https://img.shields.io/badge/Nix-Flakes-blueviolet?logo=nixos&logoColor=white)

Personal NixOS configuration using [Nix Flakes](https://nixos.wiki/wiki/Flakes) and [flake-parts](https://flake.parts/).

## Stack

| Component | Choice |
| :--- | :--- |
| **Desktop** | [Noctalia](https://github.com/noctalia-dev/noctalia) on [Niri](https://github.com/YaLTeR/niri) (Wayland) |
| **Display Manager** | [SDDM](https://github.com/sddm/sddm) with [Pixie theme](https://github.com/xCaptaiN09/pixie-sddm) |
| **Terminal** | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| **Shell** | [Fish](https://fishshell.com/) |
| **Browser** | [Zen Browser](https://github.com/youwen5/zen-browser-flake) |
| **File Manager** | [Dolphin](https://apps.kde.org/dolphin/) |
| **Editor** | [Neovim](https://neovim.io/) |

## Structure

```
nixos-config/
├── flake.nix              # Flake inputs & outputs
├── flake.lock             # Pinned input versions
├── assets/
│   └── sddm/              # SDDM login screen assets
└── modules/
    ├── parts.nix          # flake-parts wiring
    ├── core/              # Base system (boot, locale, nix, users)
    ├── desktop/           # DE & theming (niri, noctalia, theme)
    ├── hardware/          # Hardware, filesystems, swap
    ├── host/              # Machine-specific config & hostname
    └── system/            # Packages, audio, networking, security, storage
```