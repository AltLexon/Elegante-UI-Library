local rbxmSuite = loadstring((game :: any):HttpGet("https://github.com/richie0866/rbxm-suite/releases/latest/download/rbxm-suite.lua"))();
local project = rbxmSuite.download("AltLexon/Elegante-UI-Library@v1.0.0", "ui_library.rbxm");
local model = rbxmSuite.launch(project);

return rbxmSuite.require(model);