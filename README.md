# PitBull4 Forever (WoW Forever 1.60.1 / 16001)

> Unofficial WoW Forever (`16001`) port based on [nebularg/PitBull4](https://github.com/nebularg/PitBull4) (`midnight` branch) by **ckknight, Shekfi, Nebula**. All original PitBull4 credit belongs to the upstream authors.

## Why This Port?

- **Out-of-the-Box Preset (`Default` + `Hunter` Backup)**: Ships with a ready-to-use profile featuring **large, full-number health text** (no abbreviations, crisp and easy to read), plus a duplicate **`Hunter`** backup profile so you can always restore your layout if you ever tweak `Default` too far.
- **Capsule Skin & Blizzard Gold/Silver Dragon Borders**: Adds the `CapsuleSkin` module to clip unit frames into clean capsule/pill shapes, float a circular portrait with 100% bar extension behind it, and overlay Blizzard's Gold & Silver Dragon portrait frames for `worldboss`, `elite`, `rareelite`, `rare`, and optionally the `player` unit.

## Key Features

1. **WoW Forever (`16001`) Compatibility & Stability Fixes**
   - Guards `secret` values in `CombatText`, `Aura`, and `CapsuleSkin` anchor handling.
   - Fixes nil `AceLocale` keys in config-mode aura tooltips and prevents nil coordinate crashes during sticky frame dragging (`UnitFrame.lua`).
   - Guards nil class-resource frames in `HideBlizzard` and missing `GetPetHappiness` API on the 12.x engine in `HappinessIcon_Classic`.
2. **New `CapsuleSkin` Module**
   - Clips `StatusBar` / `BetterStatusBar`, backgrounds, and 2D/class portraits via `MaskTexture` into **Full Capsule**, **Soft Capsule**, **Left Semicircle**, or **Right Semicircle** shapes while hiding PitBull4's legacy square border.
   - **Floating Circular Portrait & 100% Bar Extension**: Bars extend cleanly behind the circular portrait to fill corner gaps while keeping bar-anchored texts in place; portrait diameter is adjustable (recommended `110%` of frame height) with full Blizzard chest-up framing.
   - **Blizzard Gold / Silver Dragon Overlays**: Supports per-layout dragon style (`Auto`, `Gold`, `Winged Gold`, `Silver`, `Off`), scale, X/Y offset, horizontal flip, border thickness (`Thin` / `Normal` / `Thick`), and border gap controls.
   - Full `enUS` and `zhCN` localization.
3. **Bilingual Built-in Preset (`DefaultProfile_Forever.lua`)**
   - Automatically initializes both `Default` and `Hunter` profiles on fresh installs (`PitBull4DB == nil`) in English or Chinese matching your client locale, with zero personal character/realm data included.

## Installation

- **For Players (Recommended)**: Download the packaged ZIP from the **Releases** page (includes `Libs/`) and extract the `PitBull4` folder into `Interface\AddOns\`.
- **For Developers**: Upstream `.gitignore` excludes `**/Libs`; populate `Libs/` before loading from source.

## Known Issues

- **Pet Happiness Icon (`HappinessIcon_Classic`)**: Not yet fixed. On WoW Forever (`16001`, 12.x engine), `_G.GetPetHappiness` is not available, so the pet happiness icon does not display yet (nil-guarded to prevent Lua errors).

## Credits

- Upstream PitBull4 authors: **ckknight, Shefki, Nebula** ([nebularg/PitBull4](https://github.com/nebularg/PitBull4))
- WoW Forever (`16001`) port, `CapsuleSkin` module & presets: **NickWahWah**
