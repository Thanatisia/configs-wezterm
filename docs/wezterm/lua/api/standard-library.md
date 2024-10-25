# Wezterm Lua API - Functions and Attributes/Properties/Variables

## Information
### Summary
+ This document contains a documentation of wezterm's Standard Library classes and functions

## Standard Library

### Packages/Libraries
- wezterm
    - `.action` : Wezterm Action and Keybinding
        - Format: `wezterm.action({attributes = value-here})`
        - Attributes
            - `PasteFrom = "Clipboard"` : Specify to perform the action to paste copied text from the specified system area
                + Type: String
                - Accepted Values
                    + Clipboard : Specify to perform the action to paste copied text from the system clipboard
    - `.mux`    : Wezterm Multiplexer
    - `.font`   : Wezterm Font Manager
        - Format: `wezterm.font {attributes = value-here}`
        - Attributes
            - `family="font-family-name"`  : Specify the font's family (aka 'font-family'); i.e. JetBrains Mono
                + Type: String
            - `weight="Regular|Bold|Thin"` : Specify the font's weight (how thick/thin the font's width is)
                + Type: String
                - Accepted Values
                    + Regular
                    + Bold
                    + Thin
                    + Thick
            - `stretch="Normal"`           : Specify the font's stretch value (how much to stretch the font)
                + Type: String
                - Accepted Values
                    + Normal
            - `style="Normal|Italic"`      : Specify the font's text style (i.e. if it is written in Italics)
                + Type: String
                - Accepted Values
                    + Normal
                    + Italic

### Functions
- wezterm
    - `.config_builder()` : This will hold the configuration
        - Return
            - config : The wezterm-formatted configuration master table
                + Type: Table (aka Dictionary, HashMap, Map, Associative Array)
    - `.on('event-to-trigger', event-callback-function-to-execute)` : Set/Map the wezterm Event Handler and the Event Callback Function to execute when the hook is triggered
        - Event Handlers
            + gui-startup : onStartup; Enable and customize GUI commands and functionalities to execute on startup
        - Format
            ```lua
            wezterm.on('event-to-trigger', function()
                --- Specify your Callback Function to execute when the event is triggered here
            end)
            ```

- wezterm.action : List of Keybinding Actions
    - `.ActivatePaneDirection 'Left|Right|Up|Down'` : Select the pane directly on the direction specified
        - Accepted Values
            + Left : Select the pane on the left
            + Right : Select the pane on the right
            + Up : Select the pane above
            + Down : Select the pane below
    - `.CloseCurrentPane { optional = value } }` : Close the currently-selected pane
        - Optional Values
            - `confirm = true|false` : Enable/Disable the display of a confirmation popup box for user to confirm to close the pane
                + Type: Boolean
                - Accepted Values
                    + true : Display a confirmation popup box for the user to agree
                    + false : automatically close the current pane within the tab
    - `.PromptInputLine { ... }` : Create a user input prompt to receive the name of a target shell, and create a new pane on the right starting with the specified shell
        - Format
            ```lua
            wezterm.action.PromptInputLine {
                description = "your-input-prompt-description",
                initial_value = "your-input-prompt-initial (default)-value",
                action = wezterm.action.action_callback(function(window, pane, line)
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
            ```
    - `.RotatePanes 'Clockwise|CounterClockwise'` : Rotate/Move the pane to the left/right
        - Accepted Values
            + Clockwise : Shift/Rotate/Move the pane to the right
            + CounterClockwise : Shift/Rotate/Move the pane to the left
    - `.SendKey` : Send the specified `{ key = 'subsequent-keys', mods = 'modifier' }` key combination to the terminal when pressing the assigned keybinding; 
        - Format: `wezterm.action.SendKey { mods = 'modifiers-to-press-in-ui-when-called', key = 'key-to-execute-in-ui-when-called' }`
    - `.ShowLauncher` : Popup and show the launcher menu (Equivalent to right clicking on the '+' of the tab bar)
    - `.ShowLauncherArgs` : Popup and show the selected launcher items with optional arguments and flags
        - Notes
            + Concatenate the decorations with a '|' delimiter/separator to combine multiple flags together
        - Flags
            + FUZZY : Set the launcher to search/filter all selections through a fuzzy finder
            + LAUNCH_MENU_ITEMS : Display a launch menu selection fuzzy finder
            + WORKSPACES : Display a workspaces selection fuzzy finder
            + TABS : Display a window tab selection fuzzy finder
        - Format:
            - Display a popup menu for Launch Menu Items (defined in `config.launch_menu`)
                ```lua
                wezterm.action.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' }
                ```
            - Display a popup menu for Workspace selection
                ```lua
                wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }
                ```
            - Display a popup menu for Window tabs selection
                ```lua
                wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS' }
                ```
    - `.SplitHorizontal` : Create a new pane with a horizontal split
        + Format: `wezterm.action.SplitHorizontal { attributes = values, ... }`
        - Attributes
            - `domain = "CurrentPaneDomain"` : Specify the domain to apply the split with
                - Type: String
                - Accepted Values
                    + CurrentPaneDomain : Split in the current tab in the current window
    - `.SplitVertical`   : Create a new pane with a vertical split
        + Format: `wezterm.action.SplitVertical { attributes = values, ... }`
        - Attributes
            - `domain = "CurrentPaneDomain"` : Specify the domain to apply the split with
                - Type: String
                - Accepted Values
                    + CurrentPaneDomain : Split in the current tab in the current window
    - `.SplitPane { direction = "Left|Right", command = { args = { "<your-custom-shell-or-system-command-to-execute>" } }, size = { size-options = value } }` : Split pane with the specified size to the specified direction using the custom command
        - Parameters/Attributes
            - direction : Specify the direction to split the new pane
                + Type: String
                - Accepted Values
                    + Left : Generate a new pane on the left of the currently-selected pane
                    + Right : Generate a new pane on the right of the currently-selected pane
            - command : Set the default shell/system command to be executed on startup instead of the default shell (i.e. $SHELL)
                - Optionals
                    - args : Specify an array/list of Arguments to be executed as command on creation of the new pane
                        + Format: `{ args = { "your-custom-shell-or-system-command-to-execute" } }`
            - size : Specify the size of the new pane on creation/split
                - Optionals
                    - `Percent = size-percentage` : Specify how many percent of the original size of the pane to set when splitting the new pane
                        + Type: Integer
        - Examples
            ```lua
            wezterm.action.SplitPane {
                direction = "Right",
                command = { args = { line } },
                size = { Percent = 50 },
            },
            ```
    - `.action_callback(function(window, pane, line))` : Action Callback Event Handler Function; Execute the function and pass in the parameters specified when the attached keybinding/event is triggered
        - Format
            ```lua
            wezterm.action.action_callback(function(window, pane, line)) {
                -- Specify your Callback Function to execute when the event is triggered here
                --- line will be `nil` if they hit escape without entering anything
                --- An empty string if they just hit enter
                --- Or the actual line of text they wrote
                if line then
                    --- Line is provided
                    --- Perform an action with the pane
                end
            }
            ```

## Resources

## References

## Remarks

