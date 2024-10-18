-- Wezterm Configuration file

-- Pull in the wezterm API
local wezterm = require'wezterm'
local act = wezterm.action --- Wezterm Action and Keybinding
local mux = wezterm.mux    --- Wezterm Multiplexer
local font = wezterm.font  --- Wezterm Font Manager

-- This will hold the configuration
local config = wezterm.config_builder()

-- Initialize Variables

-- Apply your configuration choices

--- Set Frontend/display configurations
config.front_end = "OpenGL"
config.default_cursor_style = "BlinkingBlock"
-- config.animation_fps = 1 --- Set the animation Frames per Second (FPS); Type: Integer/Number
-- config.cursor_blink_rate = 500 --- Set the blink rate of the cursor; Type: Integer/Number
config.term = "xterm-256color" --- Sets the TERM environment variable; Default: xterm-256color

--- Enable/Disable Terminal Emulator window flags
config.enable_scroll_bar = true --- Enable/Disable Scroll Bar

--- Set Terminal Emulator's font specifications
config.font_dirs = { 'fonts' } --- Explicitly set/specify the directories to tell Wezterm to look at first for fonts; The (default) root working directory containing the directories is starting from the same directory as your wezterm.lua file
--- config.font_locator = 'ConfigDirsOnly' --- Specify that you only want wezterm to find fonts from the 'font_dirs' directories (i.e. you want to have an isolated, self-contained wezterm configuration to carry between systems)
config.font = font("JetBrains Mono", { weight = "Regular" }) --- Set the text/foreground font of the terminal emulator

--- Changing the default programs
config.default_prog = { "<your-default-shell-or-command-here>" } --- Set the default shell/system command here

--- Set Tab/Status Bar
config.tab_bar_at_bottom = false --- Set the position of the Status/Tab bar to be at the bottom; Default: false

--- Set Window Specifications
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE" --- Configures whether the window has a title bar and/or resizable border; Options: NONE|TITLE|RESIZE|INTEGRATED_BUTTONS; Default: TITLE|RESIZE (Enable Title bar and border)
config.window_background_opacity = 0.8 --- Configures the Background opacity (transparency) of the Window; Type: Decimal/Float; Range: 0 (No opacity/transparent) - 1.0 (Full opacity)

--- Change colorscheme
config.color_scheme = "AdventureTime"

--- Set custom launch menu entries
config.launch_menu = {
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

-- Set wezterm Action and Keybindings

-- Set wezterm Multiplexer
--- Enable and customize wezterm-gui's startup GUI commands and functionalities
wezterm.on('gui-startup', function()
    --- Spawn Window
    local _, first_pane, window = mux.spawn_window {}

    --- Spawn Panes and Tabs in Window
    local _, second_pane, _ = window:spawn_tab {}
    local _, third_pane, _ = window:spawn_tab {}

    --- Send and execute system command in the new tab's shell
    --- NOTES:
    --- - '\n' : This will execute your shell command in the new tab
    --- pane_object:send_text "<your-command-here>\n"
end)

-- Return the configuration out back to wezterm
return config

