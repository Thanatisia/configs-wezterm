# CHANGELOGS

## Table of Contents
+ [2024-10-19](#2024-10-19)

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

