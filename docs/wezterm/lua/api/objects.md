# Wezterm Lua API - Terminal Emulator Objects and Functions

## Information
### Summary
+ This document contains documentation regarding Terminal Emulator objects (i.e. Tabs, Window in Tabs and Panes in Windows), as well as functions and attributes/properties/variables tied to the object type

## Objects
### Object Types
- Wezterm Lua API Objects
    - window : Manages actions against the window

### Functions
- window
    - `:perform_action( wezterm-function-to-execute, object-to-target )` : Specify the action/function to perform against the window and pane, as well as the object to target when executing within a window
        - Examples
            - Using `window.action_callback()` to pass the window in the tabs as well as the panes in the window
                ```lua
                wezterm.action_callback(function(window, pane, line)
                    if line then
                        --- Line is provided
                        --- Perform an action with the pane
                        window:perform_action(
                            --- 
                            wezterm.action.<wezterm-action-here> { ... },
                            --- Specify the object to target
                            pane
                        )
                    end
                end)
                ```

