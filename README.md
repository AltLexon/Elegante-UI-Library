# Elegante UI Library

## 📜 Module
- ### latest version
    ```lua
    local LibraryModule = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AltLexon/Elegante-UI-Library/master/run.lua"))();
    ```
- ### get version
    ```lua
    local data = { version = "1.0.0" };

    local LibraryModule = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AltLexon/Elegante-UI-Library/master/run.lua"))(data);
    ```
    

## 📦 Example
click [here](https://raw.githubusercontent.com/AltLexon/Elegante-UI-Library/master/example.lua) to see the example.
```lua
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AltLexon/Elegante-UI-Library/master/example.lua"))();
```

## 📃 Documentation
* Library
    * Show()
    * Hide()
    * CreateWindow
        * Destroy()
        * ChangeTab(**tabName**)
        * CreateTab(**name, icon**)
            * CreateTextBox(**{title, default?, callback}**)
            * CreateToggle(**{title, default?, callback}**)
            * CreateButton(**{title, callback}**)
            * CreateLabel(**{text}**)
<br>
<br>
### Made by [@altlexon](https://www.roblox.com/users/2836896939/profile)