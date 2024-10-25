# Wezterm Lua API - Configurations

## Information
### Summary
+ This document contains a documentation of wezterm's Configuration key-value settings as well as examples on usage, snippets and syntaxes

## Setup
### Pre-Requisites
- Initialize/Build the configuration master table
    ```lua
    local config = wezterm.config_builder()
    ```

## Documentations
### Configuration Key-Value Settings
- config : The configuration table
    - Set Frontend/display configurations
        - `.front_end` : Set the Frontend graphical driver/renderer
            + Type: String
            + Default: "OpenGL"
            - Accepted Values
                + OpenGL
        - `.default_cursor_style` : Set the default cursor style
            + Type: String
            + Default: "BlinkingBlock"
            - Accepted Values
                + BlinkingBlock : Blinking cursor in a block
        - `.animation_fps` : Set the animation Frames per Second (FPS; Minimum 1)
            + Type: Integer/Number
        - `.cursor_blink_rate` : Set the blink rate of the cursor
            + Type: Integer/Number
        - `.term = "xterm-256color"` : Sets the TERM environment variable
            + Type: String
            + Default: xterm-256color

    - Enable/Disable Terminal Emulator window flags
        - `.enable_scroll_bar` : Enable/Disable Scroll Bar
            + Type: Boolean
            + Default: false

    - Set Terminal Emulator's font specifications
        - `.font_dirs` : Explicitly set/specify the directories to tell Wezterm to look at first for fonts
            - Notes
                + The (default) root working directory containing the directories is starting from the same directory as your wezterm.lua file
            + Type: Indexed/Ordered List (i.e. Array/ArrayList/List)
            + Format: `{ 'directories', 'to', 'scan', 'here', ... }`
            + Recommended : `{ "fonts" }`
        - `.font_locator` : Specify that you only want wezterm to find fonts from the 'font_dirs' directories (i.e. you want to have an isolated, self-contained wezterm configuration to carry between systems)
            + Type: String
            - Accepted Values
                + 'ConfigDirsOnly' : Tell wezterm to scan for fonts **specifically** from the directories/paths listed in `config.font_dirs`
        - `.font` : Set the text/foreground font of the terminal emulator
            + Type: wezterm.font
            + Format: `config.font = font { family="font-family-name", weight="Regular|Bold|Thin", stretch="Normal", style="Normal|Italic" }`

    - Changing the default programs
        - `.default_prog` : Set the default shell/system command to be executed on startup instead of the default shell (i.e. $SHELL)
            + Type: Array/ArrayList/List
            + Format: `config.default_prog = { "<your-default-shell-or-command>" }`

    - Set Tab/Status Bar
        - `.tab_bar_at_bottom` : Set the position of the Status/Tab bar to be at the bottom
            + Type: Boolean
            + Default: false

    - Set Window Specifications
        - `.window_decorations = "INTEGRATED_BUTTONS|RESIZE"` : Configures whether the window has a title bar and/or resizable border
            + Type: String
            + Format: `config.window_decorations = "your|options|here`
            - Notes
                + Concatenate the decorations with a '|' delimiter/separator to combine multiple attributes/properties together
            - Accepted Values
                + NONE
                + TITLE
                + RESIZE
                + INTEGRATED_BUTTONS
            - Default: `config.window_decorations = "TITLE|RESIZE"` (Enable Title bar and border)
        - `.window_background_opacity` : Configures the Background opacity (transparency) of the Window
            + Type: Decimal/Float
            + Range: 0 (No opacity/transparent) - 1.0 (Full opacity)
            - Notes
                + If `config.win32_system_backdrop` or `config.macos_window_background_opacity` is set to any of the blur options, set this to 0 for the recommended effect.
            + Recommended Values: 0.8/0.9

    - Change colorscheme
        - `.color_scheme`
            + Type: String
            - Notes
                - To use an external/non-built-in colorscheme
                    + Ensure that the 'colors' directory at the root of the directory containing your wezterm.lua file
                    + Install a colorscheme by cloning/downloading the colorscheme's repository, and copying the colorscheme's '.toml' configuration file or '.lua' lua script to '/path/to/wezterm/colors'
                    + Refer to [Colorscheme - TOML file](#toml-file) for a full rundown on colorscheme TOML/Lua file usage
            - Accepted Values
                + AdventureTime

    - Set custom launch menu entries (Right Click on the 'Plus' by the tab bar)
        - `.launch_menu` : Design the launch menu's menu entries to display for selection (i.e. when running `wezterm.action.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' }`)
            + Type: Table (aka Dictionary, HashMap, Map, Associative Array)
            - Format:
                ```lua
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
                    }
                }
                ```

    - Set wezterm Action and Keybindings
        - `.leader` : Set the `<leader>` prefix to execute custom keybindings
            + Type: Table (aka Dictionary, HashMap, Map, Associative Array)
            - Modifier Labels:
                - SUPER, CMD, WIN : Windows/Super key
                - CTRL : Control Key
                - SHIFT : Shift Key
                - ALT, OPT, META : Alt key
                - LEADER : The <leader> special modal modifier state managed by wezterm
            - Notes:
                - set the leader key using 'config.leader = { key = 'leader-key', mods = 'leader-modifier', timeout_milliseconds = amount-of-time-to-wait }'
                - You can combine modifiers using the '|' operator
            + Format: `{mods = "your|leader|permission|modifiers|prefix|here", key = "leader-key-to-assign", timeout_milliseconds=time-to-live-before-leader-key-ends}`
            + Recommended: CTRL-B (`{ key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }`)
        - `.keys` : Contains a table mapping the wezterm Keybindings
            + Type: Table (aka Dictionary, HashMap, Map, Associative Array)
            - Modifier Labels:
                - SUPER, CMD, WIN : Windows/Super key
                - CTRL : Control Key
                - SHIFT : Shift Key
                - ALT, OPT, META : Alt key
                - LEADER : The <leader> special modal modifier state managed by wezterm
            - Notes:
                - set the leader key using 'config.leader = { key = 'leader-key', mods = 'leader-modifier', timeout_milliseconds = amount-of-time-to-wait }'
                - You can combine modifiers using the '|' operator
            - Format: `{ key = 'key-to-assign-to-execute-keybind', mods = 'your|permission|modifiers|prefix|here', action = 'command to execute' }`
            - Examples
                - Window Panes Key Combinations
                    ```lua
                    config.keys = { 
                        { mods = "SUPER|CMD|WIN|CTRL|SHIFT|ALT|OPT|META|LEADER", key = "subsequent-keys", action = wezterm.action.[your-wezterm-action-when-key-combination-is-pressed] { settings = value },
                    }
                    ```
                - Event: Action Event Handler; Triggers the Event Callback Function when a key combination is pressed
                    ```lua
                    config.keys = {
                        {
                            mods = "SUPER|CMD|WIN|CTRL|SHIFT|ALT|OPT|META|LEADER",
                            key = 'subsequent-keys',
                            action = wezterm.action_callback(function(win, pane)
                                -- When this key combination is pressed, execute the provided event callback function
                            end)
                        }
                    }
                    ```

## Resources

## References

## Remarks

