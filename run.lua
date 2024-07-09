local loadstring = loadstring :: any;
local game = game :: any;

local args = table.pack(...);
local version = "latest";

if #args > 0 and args[1] and rawget(args[1], "version") then
    version = "v" .. tostring(args[1].version);
end

local rbxmSuite = loadstring(game:HttpGet("https://github.com/richie0866/rbxm-suite/releases/latest/download/rbxm-suite.lua"))();
local project = rbxmSuite.download("AltLexon/Elegante-UI-Library@" .. version, "ui_library.rbxm");
local model = rbxmSuite.launch(project);

return rbxmSuite.require(model);