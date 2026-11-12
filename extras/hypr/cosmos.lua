-- Cosmos look for Hyprland: frosted glass over the living space scene,
-- violet shadows, and "warp" motion (windows pop in with a slight overshoot,
-- workspaces slide vertically, the nebula border slowly turns).
--
-- Omarchy does not load Lua from themes installed with `omarchy theme
-- install`, so this file is opt-in. To use it:
--
--   cp ~/.config/omarchy/themes/cosmos/extras/hypr/cosmos.lua ~/.config/hypr/cosmos.lua
--
-- then add this line to ~/.config/hypr/hyprland.lua, after
-- require("hypr.looknfeel"):
--
--   require("hypr.cosmos")
--
-- Remove that line to go back. The border colours themselves come from the
-- theme (colors.toml), so they apply without this file.

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 12,
    border_size = 2,
  },

  decoration = {
    rounding = 10,
    rounding_power = 3,
    dim_inactive = true,
    dim_strength = 0.08,

    shadow = {
      enabled = true,
      range = 22,
      render_power = 3,
      color = "rgba(6a4cff55)",
      color_inactive = "rgba(05060f88)",
    },

    blur = {
      enabled = true,
      size = 7,
      passes = 3,
      new_optimizations = true,
      xray = false,
      contrast = 1.0,
      brightness = 0.8,
      noise = 0.02,
      vibrancy = 0.3,
      vibrancy_darkness = 0.3,
      popups = true,
      special = true,
    },
  },
})

-- Let the scene show through file manager and terminals (active / inactive).
o.transparent_window("(org\\.gnome\\.Nautilus|com\\.mitchellh\\.ghostty|kitty|Alacritty|foot)", "0.92 0.86")

-- The nebula border slowly turns around the focused window.
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" })

-- Warp motion. Workspaces slide vertically with a fade; the Cosmos plugin
-- streaks the stars in the same direction when its `warp` option is on.
hl.curve("cosmosDrift", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("cosmosWarp", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.2, bezier = "cosmosDrift", style = "slidefadevert 25%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "cosmosDrift", style = "slidefadevert -40%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.2, bezier = "cosmosWarp", style = "popin 70%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.2, bezier = "cosmosDrift", style = "popin 60%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "cosmosDrift" })
