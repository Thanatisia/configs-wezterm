# Wezterm Colorscheme lua files - Cyberdream

## Information

### Project
+ Repository Author: scottmckendry
+ Repository Name: cyberdream.nvim
- Repositories
    + github: https://github.com/scottmckendry/cyberdream.nvim

## Setup

### Dependencies
+ git
+ wezterm

### Pre-Requisites
- Create a .config directory for wezterm
    - Windows
        ```bash
        mkdir -pv %USERPROFILE%\.config\wezterm
        ```
    - Linux
        ```bash
        mkdir -pv ~/.config/wezterm
        ```
- Colorscheme lua file Installation
    - Clone the git repository
        ```bash
        git clone https://github.com/scottmckendry/cyberdream.nvim
        ```
    - Copy the 'cyberdream.lua' script for wezterm into the wezterm root (or nested) directories
        ```bash
        cp cyberdream.nvim/extras/wezterm/cyberdream.lua /path/to/wezterm/
        ```
- Usage of colorscheme in configuration file
    ```lua
    config.colors = require("cyberdream")
    ```

## Documentations

## Resources

## References

## Remarks

