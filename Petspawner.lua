-- Load OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Create Window
local Window = OrionLib:MakeWindow({
    Name = "Grow a Garden - Visual Pet Spawner | TheScripter",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VisualPetSpawner"
})

-- Pets List
local petList = {
    "Red Fox", "Raccoon", "Dragonfly", "Mole", "Chicken Zombie",
    "Mimic Octopus", "T-Rex", "Disco Bee", "Kitsune", "Corrupted Kitsune"
}

-- Variables
local selectedPet = petList[1]
local petWeight = ""
local visualInventory = {}

-- Function to visually spawn a pet
local function spawnPet(name, weight)
    table.insert(visualInventory, {Name = name, Weight = weight})
    OrionLib:MakeNotification({
        Name = "Pet Spawned!",
        Content = "You spawned "..name.." weighing "..weight.."kg!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

-- Main Tab
local Tab = Window:MakeTab({
	Name = "Spawner",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Dropdown for pet name
Tab:AddDropdown({
	Name = "Select Pet",
	Default = petList[1],
	Options = petList,
	Callback = function(Value)
		selectedPet = Value
	end    
})

-- Weight input
Tab:AddTextbox({
	Name = "Pet Weight (kg)",
	Default = "5",
	TextDisappear = false,
	Callback = function(Value)
		petWeight = Value
	end	  
})

-- Spawn Button
Tab:AddButton({
	Name = "Spawn Visual Pet",
	Callback = function()
        if selectedPet ~= "" and petWeight ~= "" then
            spawnPet(selectedPet, petWeight)
        else
            OrionLib:MakeNotification({
                Name = "Error",
                Content = "Please select a pet and enter weight!",
                Image = "rbxassetid://4483345998",
                Time = 4
            })
        end
	end    
})

-- Inventory Tab
local InventoryTab = Window:MakeTab({
	Name = "Inventory",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- View Inventory
InventoryTab:AddButton({
	Name = "View Visual Pets",
	Callback = function()
        if #visualInventory == 0 then
            OrionLib:MakeNotification({
                Name = "Inventory Empty",
                Content = "You haven't spawned any pets yet!",
                Image = "rbxassetid://4483345998",
                Time = 4
            })
        else
            local list = "Your Visual Pets:\n"
            for i, pet in ipairs(visualInventory) do
                list = list .. i .. ". " .. pet.Name .. " (" .. pet.Weight .. "kg)\n"
            end
            OrionLib:MakeNotification({
                Name = "Inventory",
                Content = list,
                Image = "rbxassetid://4483345998",
                Time = 8
            })
        end
	end
})

-- Start UI
OrionLib:Init()
