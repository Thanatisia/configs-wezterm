-- Wezterm Configuration file

-- Pull in the wezterm API
local wezterm = require'wezterm'
local act = wezterm.action --- Wezterm Action and Keybinding
local mux = wezterm.mux    --- Wezterm Multiplexer
local font = wezterm.font  --- Wezterm Font Manager

-- This will hold the configuration
local config = wezterm.config_builder()

-- Initialize Variables
local opacity = 0.9 --- Recommended: 0.9 without background blur; 0 with background blur
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")" --- Specify the transparency Alpha Channel RGBA value
local background_colorscheme = "DefaultTransparencyNoBlur" --- Set the default background colorsheme name (from 'background_transparency_templates') for the Terminal Emulator

--- Contains a table of font names to its specifications
local font_db = {
    -- [font-family] : { family="font family name", font-specifications="value", ... }
    HackNerdFontMono = {family="Hack Nerd Font Mono", weight="Regular", stretch="Normal", style="Normal"},
    JetBrainsMonoNerdFont = {family="JetBrainsMono Nerd Font", weight="Regular", stretch="Normal", style="Normal"},
    MonocraftNerdFont = {family="Monocraft Nerd Font", weight="Regular", stretch="Normal", style="Italic"}
}

--- Contains a table mapping a transparency combination to its alpha channel and opacity/transparency values
local background_transparency_templates = {
    DefaultTransparencyNoBlur = { window_background_opacity = opacity, win32_system_backdrop = "Auto", }, --- This background colorscheme uses the default opacity set in the 'default' variable but uses no blur
    TransparentNoBlur = { window_background_opacity = 0.9, win32_system_backdrop = "Auto", }, --- This background colorscheme uses the transparency/opacity index '0.9' with no blur
    AcrylicBlur = { window_background_opacity = 0.75, win32_system_backdrop = "Acrylic", }, --- This background colorscheme uses the transparency/opacity index 0.75 with an Acrylic Blur (Windows)
}

--- Contains a table mapping of the various wezterm terminal actions to an alias/name
local wezterm_action_alias = {
    ["SendKey"] = wezterm.action.SendKey, --- Send the specified '{ key = 'subsequent-keys', mods = 'modifier' }' key combination to the terminal when pressing the assigned keybinding; Format: SendKey { key = 'keys', mods = 'modifier' }
    ["SplitHorizontal"] = wezterm.action.SplitHorizontal, --- Create a new pane with a horizontal split
    ["SplitVertical"] = wezterm.action.SplitVertical, --- Create a new pane with a vertical split
    ["ActionCallback"] = wezterm.action_callback --- Action Callback Event Handler Function; Execute a command in the background as a process when a key combination is pressed
}

--- Contains a table mapping the wezterm Keybindings
local keybindings = {
    -- { key = 'subsequent-keys to press after the modifier key', mods = 'modifier key (primary key to press first)', action = 'command to execute' }
    -- Modifier Labels:
    -- - SUPER, CMD, WIN : Windows/Super key
    -- - CTRL : Control Key
    -- - SHIFT : Shift Key
    -- - ALT, OPT, META : Alt key
    -- - LEADER : The <leader> special modal modifier state managed by wezterm
    -- Notes:
    -- - set the leader key using 'config.leader = { key = 'leader-key', mods = 'leader-modifier', timeout_milliseconds = amount-of-time-to-wait }'
    -- - You can combine modifiers using the '|' operator

    --- Defaults remap
    { key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) }, --- Remap '<CTRL|SHIFT>v' to '<CTRL>v'

    --- Wezterm Window Sessions
    { key = "l", mods = "LEADER", action = act.ShowLauncher }, --- <ALT>l; Popup and show the launcher menu (Equivalent to right clicking on the '+' of the tab bar)
    { key = "7", mods = "LEADER", action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' }, }, --- <ALT>7; Popup and show a launch menu items fuzzy finder
    { key = "8", mods = "LEADER", action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }, }, --- <ALT>8; Popup and show a workspaces fuzzy finder
    { key = "9", mods = "LEADER", action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS' }, }, --- <ALT>9; Popup and show a Tabs fuzzy finder

    --- Window Panes Key Combinations
    { key = "LeftArrow", mods = "CTRL", action = act.ActivatePaneDirection 'Left' }, --- <CTRL>LeftArrow; Select the pane directly on the left
    { key = "RightArrow", mods = "CTRL", action = act.ActivatePaneDirection 'Right' }, --- <CTRL>RightArrow; Select the pane directly on the right
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.RotatePanes 'CounterClockwise' }, --- <CTRL-SHIFT>LeftArrow; Rotate/Move the pane to the right
    { key = "RightArrow", mods = "CTRL|SHIFT", action = act.RotatePanes 'Clockwise' }, --- <CTRL-SHIFT>RightArrow; Rotate/Move the pane to the left
    { key = "UpArrow", mods = "CTRL", action = act.ActivatePaneDirection 'Up' }, --- <CTRL>UpArrow; Select the pane directly above
    { key = "DownArrow", mods = "CTRL", action = act.ActivatePaneDirection 'Down' }, --- <CTRL>DownArrow; Select the pane directly below
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } }, --- <LEADER>x; Close the currently-selected pane
    { key = "h", mods = "LEADER", action = wezterm_action_alias["SplitHorizontal"] { domain = "CurrentPaneDomain" } }, --- Create a new horizontal pane with '<CTRL-B>h'
    { key = "v", mods = "LEADER", action = wezterm_action_alias["SplitVertical"] { domain = "CurrentPaneDomain" } }, --- Create a new vertical pane with '<CTRL-B>v'
    { key = "p", mods = "LEADER", action =
        --- <LEADER>t; Create a user input prompt to receive the name of a target shell, and create a new pane on the right starting with the specified shell
        act.PromptInputLine {
            description = "Obtain a shell and create a split horizontally using that shell",
            initial_value = "bash",
            action = wezterm_action_alias["ActionCallback"](function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    --- Line is provided
                    --- Perform an action with the pane
                    window:perform_action(
                        --- Specify the action to perform
                        act.SplitPane {
                            --- Split pane with the specified size to the specified direction using the custom command
                            direction = "Right",
                            command = { args = { line } },
                            size = { Percent = 50 },
                        },
                        --- Specify the object to target
                        pane
                    )
                end
            end),
        }
    },

    --- Event: Action Event Handler; Triggers the Event Callback Function when a key combination is pressed
    {
        mods = "LEADER",
        key = 'k',
        action = wezterm_action_alias["ActionCallback"](function(win, pane)
            -- When this key combination is pressed, execute the provided event callback function

            --- Spawn a new Window, Tab, and Pane
            --- local _, new_pane, window = mux.spawn_window {}

            --- Split and spawn a new pane
            local new_pane = pane:split { }

            --- Pass command to the new pane to be executed
            new_pane:send_text "wezterm show-keys\r\n"
        end)
    }
}

--- Contains a table mapping the wezterm Event Handler to its Event Callback Function to execute when the hook is triggered
local wezterm_event_handler_config = {
    -- ['wezterm-event-handler'] = event-callback-function-to-execute

    --- Event: onStartup; Enable and customize GUI commands and functionalities to execute on startup
    ['gui-startup'] = function()
        --- Spawn Window
        local _, first_pane, window = mux.spawn_window {}

        --- Spawn Panes and Tabs in Window
        local _, second_pane, _ = window:spawn_tab {}
        local _, third_pane, _ = window:spawn_tab {}

        --- Send and execute system command in the new tab's shell
        --- NOTES:
        --- - '\n' : This will execute your shell command in the new tab
        --- pane_object:send_text "<your-command-here>\n"
    end,
    --- Event: Update Status Information; Update Status Bar to display system information/anything set on the window
    ['update-status'] = function(window, pane)
      -- Grab the utf8 character for the "powerline" left-facing solid arrow.
      local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

      -- Grab the current window's configuration, and from it the palette (this is the combination of your chosen colour scheme including any overrides).
      local color_scheme = window:effective_config().resolved_palette
      local bg = color_scheme.background
      local fg = color_scheme.foreground

      -- Set the following text configuration to the right side of the window
      window:set_right_status(wezterm.format({
        -- First, we draw the arrow...
        { Background = { Color = 'none' } },
        { Foreground = { Color = bg } },
        { Text = SOLID_LEFT_ARROW },
        -- Then we draw our text
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = ' ' .. wezterm.hostname() .. ' ' },
      }))
    end
}

--- Contains a table mapping the wezterm terminal emulator configuration key to its value(s)
local config_table = {
    --- Set Frontend/display configurations
    front_end = "OpenGL", --- Set the Frontend graphical driver/renderer
    default_cursor_style = "BlinkingBlock",
    -- animation_fps = 1, --- Set the animation Frames per Second (FPS); Type: Integer/Number
    -- cursor_blink_rate = 500, --- Set the blink rate of the cursor; Type: Integer/Number
    term = "xterm-256color", --- Sets the TERM environment variable; Default: xterm-256color

    --- Enable/Disable Terminal Emulator window flags
    enable_scroll_bar = true, --- Enable/Disable Scroll Bar

    --- Set Terminal Emulator's font specifications
    font_dirs = { 'fonts' }, --- Explicitly set/specify the directories to tell Wezterm to look at first for fonts; The (default) root working directory containing the directories is starting from the same directory as your wezterm.lua file
    --- font_locator = 'ConfigDirsOnly', --- Specify that you only want wezterm to find fonts from the 'font_dirs' directories (i.e. you want to have an isolated, self-contained wezterm configuration to carry between systems)
    --- font = font("JetBrains Mono", { weight = "Regular" }), --- Set the text/foreground font of the terminal emulator; Please ensure that the font is installed in the font directory (i.e. [HOME]/fonts or [HOME]/.config/wezterm/fonts)

    --- Changing the default programs
    default_prog = { "<your-default-shell-or-command-here>" }, --- Set the default shell/system command here

    --- Set Tab/Status Bar
    tab_bar_at_bottom = false, --- Set the position of the Status/Tab bar to be at the bottom; Default: false

    --- Set Window Specifications
    window_decorations = "INTEGRATED_BUTTONS|RESIZE", --- Configures whether the window has a title bar and/or resizable border; Options: NONE|TITLE|RESIZE|INTEGRATED_BUTTONS; Default: TITLE|RESIZE (Enable Title bar and border)
    window_background_opacity = background_transparency_templates[background_colorscheme].window_background_opacity, --- Configures the Background opacity (transparency) of the Window; Type: Decimal/Float; Range: 0 (No opacity/transparent) - 1.0 (Full opacity)
    win32_system_backdrop = background_transparency_templates[background_colorscheme].win32_system_backdrop, --- When combined with 'window_background_opacity', the chosen value will set a background effect to the window; Valid Options: Auto|Disable|Acrylic|Mica|Tabbed; The MacOS equivalent is 'macos_window_background_blur' which requires an alpha channel index

    --- Change colorscheme
    color_scheme = "AdventureTime",

    --- Clipboard
    canonicalize_pasted_newlines = "CarriageReturn", --- Controls whether pasted texts will have newlines normalized

    --- Set custom launch menu entries
    launch_menu = {
        {
            label = "Command Prompt",
            args = { "cmd.exe" },
        },
        {
            -- Optional label to show in the launcher. If omitted, a label
            -- is derived from the `args`
            label = 'Bash',
            -- The argument array to spawn.  If omitted the default program
            -- will be used as described in the documentation above
            args = { "bash" }, --- Set your shell/system command here

            -- You can specify an alternative current working directory;
            -- if you don't specify one then a default based on the OSC 7
            -- escape sequence will be used (see the Shell Integration
            -- docs), falling back to the home directory.
            -- cwd = "/some/path"

            -- You can override environment variables just for this command
            -- by setting this here.  It has the same semantics as the main
            -- set_environment_variables configuration option described above
            -- set_environment_variables = { FOO = "bar" },
        },
    }
}

-- Apply your configuration choices
for key, value in pairs(config_table) do
    --- This is equivalent to 'config.[key] = value
    config[key] = value
end

-- Set wezterm Action and Keybindings
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 } --- Set the <leader> prefix to execute custom keybindings; Current: CTRL-B
config.keys = keybindings

-- Set wezterm Event Handler and the Event Callback Function to execute
for key, value in pairs(wezterm_event_handler_config) do
    wezterm.on(key, value)
end

-- Return the configuration out back to wezterm
return config

