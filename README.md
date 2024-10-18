# Wezterm

## Information
### Summary
+ This documentation contains a quickstart guide on setting up Wezterm and configuring into a working Terminal Emulator

### Project
+ Author: wezterm
+ Application: wezterm
+ Website: https://wezfurlong.org/wezterm/
- Repositories
    + GitHub: https://github.com/wezterm/wezterm

## Setup

### Dependencies
+ git
+ wezterm

### Pre-Requisites
- Place the source folder into your configuration directory
    - Home directory
        ```bash
        cp src/wezterm.lua ~/.wezterm.lua
        ```
    - XDG Configurations directory ('~/.config/wezterm/')
        ```bash
        cp -r src/ ~/.config/wezterm
        ```

## Configuration

### Environment Variables
+ `WEZTERM_CONFIG_DIR=/path/to/wezterm/configurations/root/directory` : Explicitly specify the path to wezterm's configuration directory
+ `WEZTERM_CONFIG_FILE=/path/to/wezterm/configuration/file/wezterm.lua` : Explicitly specify the path to wezterm's configuration file (Default: $HOME/.wezterm.lua)
+ `WEZTERM_EXECUTABLE=/path/to/wezterm/executable/wezterm-gui.exe` : Set the wezterm executable file path and name; Set automatically by the binary/executable
+ `WEZTERM_EXECUTABLE_DIR=/path/to/wezterm/executable/directory` : Set the wezterm executable file's directory; Set automatically by the binary/executable
+ `WEZTERM_PANE=[PANE_ID]` : Contains the Pane ID currently-selected Pane within the current window and tab
+ `WEZTERM_PATH=/path/to/wezterm/executable/directory` : Same as `WEZTERM_EXECUTABLE_DIR`
+ `WEZTERM_UNIX_SOCKET=/path/to/wezterm/gui-sock-[socket-id]` : Contains the wezterm GUI socket object file; Set automatically by the binary/executable

### Configuration Structure Layout Hierarchy

> Using the home directory

```bash
$HOME/
|
|-- fonts/
|-- .wezterm.lua
```

> Using '.config'

```bash
$HOME/
|
|-- .config/
    |
    |-- wezterm/
        |
        |-- fonts/
        |-- wezterm.lua
```

### Initial Setup
- Setup the configuration file structure layout
    - Using the home directory
        - Create the miscelleneous asset directories
            - Explanation
                - The (default) root working directory containing the directories is starting from the same directory as your wezterm.lua file
                    + Windows: `%USERPROFILE%\<directory-here>`
                    + Linux: `$HOME/<directory-here>`
            - Create fonts directory
                - Windows
                    ```bash
                    mkdir %USERPROFILE%\fonts
                    ```
                - Linux
                    ```bash
                    mkdir -pv $HOME/fonts
                    ```
        - Create the lua configuration file '.wezterm.lua'
            - Windows
                ```bash
                echo -e "" >> %USERPROFILE%\.wezterm.lua
                ```
            - Linux
                ```bash
                touch $HOME/.wezterm.lua
                ```
    - Using the XDG .config directory
        - Create the wezterm configuration directory
            - Windows
                ```bash
                mkdir %USERPROFILE%\.config\wezterm
                ```
            - Linux
                ```bash
                mkdir -pv $HOME/.config/wezterm
                ```
        - Create the miscelleneous asset directories
            - Explanation
                - The (default) root working directory containing the directories is starting from the same directory as your wezterm.lua file
                    + Windows: `%USERPROFILE%\.config\wezterm\<directory-here>`
                    + Linux: `$HOME/.config/wezterm/<directory-here>`
            - Create fonts directory
                - Windows
                    ```bash
                    mkdir %USERPROFILE%\.config\wezterm\fonts
                    ```
                - Linux
                    ```bash
                    mkdir -pv $HOME/.config/wezterm/fonts
                    ```
        - Create the lua configuration file in '$HOME/.config'
            ```bash
            touch $HOME/.config/wezterm/wezterm.lua
            ```

- (Optional) If you are using `~/.config/wezterm/wezterm.lua`
    - Edit Environment Variables
        - Set `WEZTERM_CONFIG_DIR` to specify the path to wezterm's configuration directory (Default: $HOME)
            - Windows
                ```bash
                SET WEZTERM_CONFIG_DIR=%USERPROFILE%\.config\wezterm
                ```
            - Linux
                ```bash
                export WEZTERM_CONFIG_DIR=~/.config/wezterm
                ```
        - Set `WEZTERM_CONFIG_FILE` to specify the path to wezterm's configuration file (Default: $HOME/.wezterm.lua)
            - Windows
                ```bash
                SET WEZTERM_CONFIG_FILE=%USERPROFILE%\.config\wezterm\wezterm.lua
                ```
            - Linux
                ```bash
                export WEZTERM_CONFIG_FILE=~/.config/wezterm/wezterm.lua
                ```

- Populate configuration file
    - Edit the lua configuration file (/path/to/wezterm.lua)
        ```bash
        $EDITOR /path/to/wezterm.lua
        ```
    - Populate with initial configuration
        - Explanation
            - Pull in the wezterm API and its component libraries
                ```lua
                local wezterm = require'wezterm'
                local act = wezterm.action --- Wezterm Action and Keybinding
                local mux = wezterm.mux    --- Wezterm Multiplexer
                local font = wezterm.font  --- Wezterm Font Manager
                ```
            - Build the configuration container
                ```lua
                local config = wezterm.config_builder()
                ```
            - Return the configuration master table back out/up to wezterm (caller function)
                ```lua
                return config
                ```
        ```lua
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
        config.front_end = "OpenGL" --- Set the Frontend graphical driver/renderer
        config.default_cursor_style = "BlinkingBlock"
        -- config.animation_fps = 1 --- Set the animation Frames per Second (FPS); Type: Integer/Number
        -- config.cursor_blink_rate = 500 --- Set the blink rate of the cursor; Type: Integer/Number
        config.term = "xterm-256color" --- Sets the TERM environment variable; Default: xterm-256color

        --- Enable/Disable Terminal Emulator window flags
        config.enable_scroll_bar = true --- Enable/Disable Scroll Bar

        --- Set Terminal Emulator's font specifications
        config.font_dirs = { 'fonts' } --- Explicitly set/specify the directories to tell Wezterm to look at first for fonts; The (default) root working directory containing the directories is starting from the same directory as your wezterm.lua file
        --- config.font_locator = 'ConfigDirsOnly' --- Specify that you only want wezterm to find fonts from the 'font_dirs' directories (i.e. you want to have an isolated, self-contained wezterm configuration to carry between systems)
        --- config.font = font { family="font-family-name", weight="Regular|Bold|Thin", stretch="Normal", style="Normal|Italic" } --- Set the text/foreground font of the terminal emulator

        --- Changing the default programs
        config.default_prog = { "<your-default-shell-or-command>" } --- Set the default shell instead of cmd

        --- Set Tab/Status Bar
        config.tab_bar_at_bottom = false --- Set the position of the Status/Tab bar to be at the bottom; Default: false

        --- Set Window Specifications
        config.window_decorations = "INTEGRATED_BUTTONS|RESIZE" --- Configures whether the window has a title bar and/or resizable border; Options: NONE|TITLE|RESIZE|INTEGRATED_BUTTONS; Default: TITLE|RESIZE (Enable Title bar and border)
        config.window_background_opacity = 0.8 --- Configures the Background opacity (transparency) of the Window; Type: Decimal/Float; Range: 0 (No opacity/transparent) - 1.0 (Full opacity)

        --- Change colorscheme
        config.color_scheme = "AdventureTime"

        --- Set custom launch menu entries (Right Click on the 'Plus' by the tab bar)
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

        -- Set wezterm Action and Keybindings
        config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 } --- Set the <leader> prefix to execute custom keybindings; Current: CTRL-B
        config.keys = { 
            --- Contains a table mapping the wezterm Keybindings
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
            { mods = "SUPER|CMD|WIN|CTRL|SHIFT|ALT|OPT|META|LEADER", key = "subsequent-keys", action = wezterm.action.[your-wezterm-action-when-key-combination-is-pressed] { settings = value },

            --- Event: Action Event Handler; Triggers the Event Callback Function when a key combination is pressed
            {
                mods = "SUPER|CMD|WIN|CTRL|SHIFT|ALT|OPT|META|LEADER",
                key = 'subsequent-keys',
                action = wezterm.action_callback(function(win, pane)
                    -- When this key combination is pressed, execute the provided event callback function
                end)
            }
        }

        -- Set wezterm Event Handler and the Event Callback Function to execute
        --- Event: onStartup; Enable and customize GUI commands and functionalities to execute on startup
        wezterm.on('gui-startup', function()
            --- Specify your Callback Function to execute when the event is triggered here
        end)

        -- Return the configuration out back to wezterm
        return config
        ```

### Wezterm Lua API

#### Initial Configuration File Setup
- Pull in the Wezterm API
    ```lua
    local wezterm = require'wezterm'
    ```

- Initialize the Wezterm component libraries/packages
    - Weztrm Action and Keybindings
        ```lua
        local act = wezterm.action
        ```
    - Wezterm Multiplexer Server (Background Process) Configurations
        ```lua
        local mux = wezterm.mux
        ```
    - Wezterm Font Management
        ```lua
        local font = wezterm.font
        ```

- Initialize the configuration builder to hold the configuration key-value settings
    ```lua
    -- This will hold the configuration
    local config = wezterm.config_builder()
    ```

### Terminal Emulator Settings Configuration
- Apply your configuration choices
    - Setting the configuration key using `config.<key>=value`
        ```lua
        config.<settings-key> = value
        ```
    - Setting the configuration key using `config[key]=value`
        ```lua
        config["settings-key"] = value
        ```

### Keybindings
- Set the 'LEADER' PREFIX for the terminal emulator
    - Explanation
        + Set the `<leader>` prefix to execute custom keybindings
        + Format: `modifier + key`
        + Usage: `[modifier + key]<your-subsequent-keys>`
        + This is similar to vim's 'leader' prefix and emac's prefix
    ```lua
    config.leader = { mods = '<your-leader-modifier>', key = '<your-prefix-keys>', timeout_milliseconds = 1000 }
    ```

- Set Keybindings for the Terminal Emulator
    - Explanation
        + Format: `{ key = 'subsequent-keys to press after the modifier key', mods = 'modifier key (primary key to press first)', action = 'command to execute' }`
        - Modifier Labels:
            + SUPER, CMD, WIN : Windows/Super key
            + CTRL : Control Key
            + SHIFT : Shift Key
            + ALT, OPT, META : Alt key
            + LEADER : The `<leader>` special modal modifier state managed by wezterm
        + When the key `<modifier + key>subsequent-keys` is pressed, execute the action
    - Notes:
        + set the leader key using `config.leader = { key = 'leader-key', mods = 'leader-modifier', timeout_milliseconds = amount-of-time-to-wait }`
        + You can combine modifiers using the '|' operator
    - Wezterm Terminal Emulator Action Key Combinations
        ```lua
        config.keys = {
            { mods = "SUPER|CMD|WIN|CTRL|SHIFT|ALT|OPT|META|LEADER", key = "your-subsequent-keys", action = wezterm.action.[your-wezterm-action-when-key-combination-is-pressed] },
            -- ...
        }
        ```
    - Wezterm Windows, Tabs and Panes Handler Key Combinations
        ```lua
        config.keys = {
            { mods = "SUPER|CMD|WIN|CTRL|SHIFT|ALT|OPT|META|LEADER", key = "your-subsequent-keys", action = wezterm.action_callback(
                function(win, pane)
                    --- Event Callback Function Statements to execute when the key combination is pressed
                end)
            },
            -- ...
        }
        ```

### Window Management
- Spawn a new Window and a new Tab and Pane within the new Window
    ```lua
    local tab, pane, window = mux.spawn_window {}
    ```

- Spawn Panes and Tabs in the current/specified Window object instance
    ```lua
    local new_tab, new_pane, _ = window:spawn_tab {}
    ```

- Split and spawn a new pane from the current pane in the same window and tab
    ```lua
    local new_pane = pane:split { }
    ```

- Send a command to a pane instance object and execute the system command in the new pane/tab's shell
    - Notes
        - `pane:send_text`: This will execute your shell command in the new tab
        - '\r\n' : This is an escape sequence to go to the new line (Carriage Return); In UNIX, the carriage return is '\n' while in Windows/DOS, the carriage return is '\r\n'
    ```lua
    pane:send_text "your command arguments here\r\n"
    ```

### Terminal Emulator Event Handler Hooks and Callback Functions
- To set/enable an Event to monitor
    ```lua
    wezterm.on('event-name', function()
        -- Event Callback Function Statements to execute if event is triggered
    end)
    ```

## Documentations

### CLI Utility
#### Synopsis/Syntax
```bash
wezterm [action] {options} <arguments>
```

#### Parameters
> Positional
- Actions
    + `ls-fonts` : List all fonts and obtain the font family as well as wezterm lua-formatted configuration settings
    + `show-keys` : Show all Keybindings

> Optionals
- With Arguments
- Flags
    + `--list-system` : List those detected/found in the system

#### Usage
- List/Show all fonts detected in the system and obtain the font family and information
    ```bash
    wezterm ls-fonts --list-system
    ```

- Filter fonts detected in the system and obtain the font family and information
    ```bash
    wezterm ls-fonts --list-system | grep [Font Filter]
    ```

- Show all keybindings
    ```bash
    wezterm show-keys
    ```

- Show Keybinding filters
    - Window-related Key Combinations
        ```bash
        wezterm show-keys | grep "Window"
        ```
    - Tab-related Key Combinations
        ```bash
        wezterm show-keys | grep "Tab"
        ```
    - Panes-related Key Combinations
        ```bash
        wezterm show-keys | grep "Pane"
        ```
    - Modifier-filter
        ```bash
        wezterm show-keys | grep "MOD-1|MOD-2|..."
        ```

## Wiki

### Templates

> wezterm.lua

```lua
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

--- Method 1
config.<configuration-keyword> = "value"

--- Method 2
config[configuration-setting] = "value"

-- Set wezterm Action and Keybindings
config.keys = { 
    --- Contains a table mapping the wezterm Keybindings
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
    { mods = "SUPER|CMD|WIN|CTRL|SHIFT|ALT|OPT|META|LEADER", key = "subsequent-keys", action = wezterm.action.[your-wezterm-action-when-key-combination-is-pressed] { settings = value },

    --- Event: Action Event Handler; Triggers the Event Callback Function when a key combination is pressed
    {
        mods = "SUPER|CMD|WIN|CTRL|SHIFT|ALT|OPT|META|LEADER",
        key = 'subsequent-keys',
        action = wezterm.action_callback(function(win, pane)
            -- When this key combination is pressed, execute the provided event callback function
        end)
    }
}

-- Set wezterm Event Handler and the Event Callback Function to execute
--- Event: onStartup; Enable and customize GUI commands and functionalities to execute on startup
wezterm.on('gui-startup', function()
    --- Specify your Callback Function to execute when the event is triggered here
end)

-- Return the configuration out back to wezterm
return config
```

## Snippets

1. No Windows Bar, Tab Bar + Windows Decoration, Background Transparency

```lua
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

    --- Window Panes Key Combinations
    { key = "h", mods = "LEADER", action = wezterm_action_alias["SplitHorizontal"] { domain = "CurrentPaneDomain" } }, --- Create a new horizontal pane with '<CTRL-B>h'
    { key = "v", mods = "LEADER", action = wezterm_action_alias["SplitVertical"] { domain = "CurrentPaneDomain" } }, --- Create a new vertical pane with '<CTRL-B>v'

    --- Event: Action Event Handler; Triggers the Event Callback Function when a key combination is pressed
    {
        --- Press '<leader>k' to split open a new pane and show all wezterm keybindings
        mods = "LEADER",
        key = 'k',
        action = wezterm.action_callback(function(win, pane)
            -- When this key combination is pressed, execute the provided event callback function

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
        -- Open up a new window, create 3 panes and execute a command on the first pane

        --- Spawn Window
        local _, first_pane, window = mux.spawn_window {}

        --- Spawn Panes and Tabs in Window
        local _, second_pane, _ = window:spawn_tab {}
        local _, third_pane, _ = window:spawn_tab {}

        --- Send and execute system command in the new tab's shell
        --- NOTES:
        --- - '\n' : This will execute your shell command in the new tab
        --- pane_object:send_text "<your-command-here>\n"
        first_pane:send_text "command arguments here\n"
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
    font = font(font_db["JetBrainsMonoNerdFont"]), --- Set the text/foreground font of the terminal emulator

    --- Changing the default programs
    default_prog = { "cmd" }, --- Set the default program to execute on startup

    --- Set Tab/Status Bar
    tab_bar_at_bottom = false, --- Set the position of the Status/Tab bar to be at the bottom; Default: false

    --- Set Window Specifications
    window_decorations = "INTEGRATED_BUTTONS|RESIZE", --- Configures whether the window has a title bar and/or resizable border; Options: NONE|TITLE|RESIZE|INTEGRATED_BUTTONS; Default: TITLE|RESIZE (Enable Title bar and border)
    window_background_opacity = 0.8, --- Configures the Background opacity (transparency) of the Window; Type: Decimal/Float; Range: 0 (No opacity/transparent) - 1.0 (Full opacity)

    --- Change colorscheme
    color_scheme = "AdventureTime",

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
            args = { "Bash" }, --- Set your shell/system command here (i.e. /bin/bash -c "system-command-here")

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
```

## Resources

## References
+ [wezterm - Documentations - Configuration - lua - Configurations - font_dirs](https://wezfurlong.org/wezterm/config/lua/config/font_dirs.html)
+ [wezterm - Documentations - Configuration - lua - Configurations - Window Decorations](https://wezfurlong.org/wezterm/config/lua/config/window_decorations.html)
+ [wezterm - Documentations - Configuration - lua - pane - split](https://wezfurlong.org/wezterm/config/lua/pane/split.html?h=pane)

## Remarks

