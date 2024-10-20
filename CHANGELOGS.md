# CHANGELOGS

## Table of Contents
+ [2024-10-19](#2024-10-19)
+ [2024-10-20](#2024-10-20)

## Logs
### 2024-10-19
#### 0005H
+ Initial Commit

- New
    + Added new document 'README.md'
    + Added new document 'CHANGELOGS.md'
    - Added new directory 'src/' for configuration/source files
        - Added new document 'wezterm.lua' : wezterm Configuration File

#### 1032H
- Updates
    - Updated document 'wezterm.lua' in 'src/'
        + Added new config update
        - Reconfigured the config file to follow a 'individual configuration variables' style for each components (i.e. keybindings, terminal emulator config, event handler)
            + The execution of the settings will be done in a for loop (unless it accepts a table as a parameter)

### 2024-10-20
#### 2114H
- Updates
    - Updated document 'wezterm.lua' in 'src/'
        + Added new variables for background transparency/opacity
        + Added keybinding defaults remap: 'CTRL-SHIFT-v' => 'CTRL-v' to paste the clipboard
        + Added new keybindings for Window Session and launcher handling
        + Added new keybinding for obtaining user input via a popup prompt menu and splitting a new pane with the new shell
        + Replaced the hard-coded opacity alpha channel value of 'window_background_opacity' to the defined variable 'opacity'
        + Added setting for background blurring

