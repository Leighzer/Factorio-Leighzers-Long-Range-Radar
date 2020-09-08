data:extend(
{  
    {
        type = "double-setting",
        name = "energyUsagekW",
        setting_type = "startup",
        default_value = 1000,
        minimum_value = 1/1000,
        order = "a"
    },

    {
        type = "double-setting",
        name = "maxDistanceOfSectorRevealed",
        setting_type = "startup",
        default_value = 28,
        minimum_value = 0,
        maximum_value = 4294967295,
        order = "b"
    }

})