# CHANGELOGS

## Table of Contents
+ [2024-10-19](#2024-10-19)
+ [2024-10-20](#2024-10-20)
+ [2024-10-21](#2024-10-21)
+ [2024-10-25](#2024-10-25)

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

### 2024-10-21
#### 1619H
- Updates
    - Updated document 'wezterm.lua' in 'src/'
        - Added a table mapping a transparency combination to => alpha channel and opacity/transparency values (Dictionary of transparency colorschemes)
            + Testing to see which configuration format looks nicer
        - Modified windows window_background_opacity and win32_system_backdrop to reference the transparency colorscheme map instead of hard-coded
            + Added a default background transparency colorscheme

#### 1630H
- New
    - Added new directory 'templates' for storing some wezterm configuration file templates
- Updates
    - Updated document 'wezterm.lua' in 'src/'
        - Added new keybindings
            + '<CTRL>LeftArrow'        : Select the pane directly on the left
            + '<CTRL>RightArrow'       : Select the pane directly on the right
            + '<CTRL-SHIFT>LeftArrow'  : Rotate/Move the pane to the right
            + '<CTRL-SHIFT>RightArrow' : Rotate/Move the pane to the left
            + '<CTRL>UpArrow'          : Select the pane directly above
            + '<CTRL>DownArrow'        : Select the pane directly below
            + '<LEADER>x'              : Close the currently-selected pane

#### 1644H
- New
    - Added new directory 'docs' for other documentations and side-information
        - Added new directory 'colorschemes' for various useful/nice .toml and .lua colorschemes
            - Added new directory 'lua' for *.lua script-based colorscheme
                + Added new colorscheme document 'cyberdream.md' for the colorscheme 'scottmckendry/cyberdream.nvim'
            - Added new directory 'toml' for *.toml configuration file-based colorschemes
                + Added new colorscheme document 'hardhacker.md' for the colorscheme 'hardhackerlabs/themes-wezterm'
- Updates
    - Updated document 'README.md'
        + Updated information on file structure and layout/hierarchy
        + Added documentation for customizing wezterm Terminal Emulator's colorscheme

### 2024-10-25
#### 0959H
- New
    - Added new directory 'wezterm' in 'docs/' for wezterm-related documentations
        - Added new directory 'lua' for wezterm lua scripting documentations
            - Added new directory 'api' for documentations specifically regarding the wezterm lua API
                + Added new document 'configurations.md' containing docs containing the setting of Wezterm configuration key-values
                + Added new document 'objects.md' containing docs regarding the Wezterm Objects (i.e. Tabs, Windows and Panes)
                + Added new document 'standard-library.md' containing docs regarding the Wezterm Lua API standard library classes and functions
- Updates
    - Updated document 'README.md'
        + Restructured/shuffled/shifted various section/segments for a better reading experience

