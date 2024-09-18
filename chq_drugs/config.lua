Config = {}

Config.Target = true -- Whether you want to use QB-Target

Config.Cocaine = {
    -- prop_plant_fern_02a
    ["cocaleaf"] = { -- plantPos, can change :D
        ["position"] = {
            [1] = {
                x = 2590.26, 
                y = 6166.63,
                z = 166.02
            },
            [2] = { 
                x = 2584.32,
                y = 6172.07,
                z = 165.09
            },
            [3] = { 
                x = 2597.85,
                y = 6149.06,
                z = 167.34
            },
            [4] = {
                x = 2611.66,
                y = 6159.6,
                z = 175.55
            }
        }
    },
    ["grinder"] = { -- grinderPos, DO NOT CHANGE unless you know how to edit PolyZones
        ["position"] = { -- 3 leaves = 1 coke
            [1] = {
                x = 327.41,
                y = -1009.27,
                z = 29.29
            }
        }
    }
    -- grinder object in client using PolyZones
}

Config.Meth = {
    ["cost"] = {
        ["hydrogen"] = 3,
        ["causticsoda"] = 3,
        ["muriaticacid"] = 3
    }
    -- pack location in client using PolyZones
}

