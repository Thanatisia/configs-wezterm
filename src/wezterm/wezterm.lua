-- Wezterm Configuration file

-- Pull in the wezterm API
local wezterm = require'wezterm'
local act = wezterm.action --- Wezterm Action and Keybinding
local mux = wezterm.mux    --- Wezterm Multiplexer
local font = wezterm.font  --- Wezterm Font Manager

-- This will hold the configuration
local config = wezterm.config_builder()

-- Initialize Variables

--- Contains a table of font names to its specifications
local font_db = {
    -- [font-family] : { family="font family name", font-specifications="value", ... }
    HackNerdFontMono = {family="Hack Nerd Font Mono", weight="Regular", stretch="Normal", style="Normal"},
    JetBrainsMonoNerdFont = {family="JetBrainsMono Nerd Font", weight="Regular", stretch="Normal", style="Normal"},
    MonocraftNerdFont = {family="Monocraft Nerd Font", weight="Regular", stretch="Normal", style="Italic"}
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

    --- Window Panes Key Combinations
    { key = "h", mods = "LEADER", action = wezterm_action_alias["SplitHorizontal"] { domain = "CurrentPaneDomain" } }, --- Create a new horizontal pane with '<CTRL-B>h'
    { key = "v", mods = "LEADER", action = wezterm_action_alias["SplitVertical"] { domain = "CurrentPaneDomain" } }, --- Create a new vertical pane with '<CTRL-B>v'

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
    window_background_opacity = 0.8, --- Configures the Background opacity (transparency) of the Window; Type: Decimal/Float; Range: 0 (No opacity/transparent) - 1.0 (Full opacity)

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

