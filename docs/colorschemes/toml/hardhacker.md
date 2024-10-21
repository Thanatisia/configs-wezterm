# Wezterm Colorscheme lua files - HardHacker

## Information

### Project
+ Repository Author: hardhackerlabs
+ Repository Name: theme-wezterm
- Repositories
    + github: https://github.com/hardhackerlabs/theme-wezterm

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
- Create the 'colors' assets directory
    - Windows
        ```bash
        mkdir -pv %USERPROFILE%\.config\wezterm\colors
        ```
    - Linux
        ```bash
        mkdir -pv ~/.config/wezterm/colors
        ```
- Colorscheme lua file Installation
    - Clone the git repository
        ```bash
        git clone https://github.com/hardhackerlabs/theme-wezterm
        ```
    - Copy the 'hardhacker.toml' script for wezterm into the colors directory
        ```bash
        cp theme-wezterm/hardhacker.toml /path/to/wezterm/colors/
        ```
- Usage of colorscheme in configuration file
    ```lua
    config.color_scheme = "hardhacker"
    ```

## Documentations

## Resources

## References

## Remarks

