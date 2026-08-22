-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Chrome-safe fullscreen: fill the screen without telling apps (Chrome) they
-- are fullscreen, so Chrome doesn't hide its tab bar. Toggles based on the
-- active window's current fullscreen state (setting internal=2 is NOT a
-- toggle by itself, so we check state first). Was: fullscreen.
hl.unbind("SUPER + F")
o.bind("SUPER + F", "Chrome-safe fullscreen", function()
  local win = hl.get_active_window()
  if not win then
    return
  end
  if win.fullscreen == 0 then
    hl.dispatch(hl.dsp.window.fullscreen_state({ internal = 2, client = 0 }))
  else
    hl.dispatch(hl.dsp.window.fullscreen_state({ internal = 0, client = 0 }))
  end
end)

-- Change an existing binding by unbinding it fir.
-- hl.unbind("SUPER + SHIFT + B")
-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
