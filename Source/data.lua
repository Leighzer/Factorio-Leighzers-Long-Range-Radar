if not leighzermods then --generic mod variable to store information that may be needed later
  leighzermods = {}        
end

if not leighzermods.leighzerlongrangeradar then
  leighzermods.leighzerlongrangeradar = {}

  leighzermods.leighzerlongrangeradar.energyUsagekW = settings.startup["energyUsagekW"].value
  leighzermods.leighzerlongrangeradar.maxDistanceOfSectorRevealed = settings.startup["maxDistanceOfSectorRevealed"].value
end

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

--add item
--add recipe
--add actual radar that scans things
--add recipe unlock on military-3 research

data:extend({
  {
    type = "item",
    name = "long-range-radar",
    icon = "__leighzerlongrangeradar__/graphics/icons/long-range-radar.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "defensive-structure",
    order = "d[radar]-a[radar]-a",
    place_result = "long-range-radar",
    stack_size = 50,
  },
  {
    type = "recipe",
    name = "long-range-radar",
    enabled = false,
    ingredients =
    {
      {"advanced-circuit", 5},
      {"iron-gear-wheel", 5},
      {"steel-plate", 10},
      {"radar", 2}
    },    
    result = "long-range-radar",
  },
  {
    type = "radar",
    name = "long-range-radar",
    icon = "__leighzerlongrangeradar__/graphics/icons/long-range-radar.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "long-range-radar"},
    max_health = 500, -- 250,
    corpse = "medium-remnants", -- "radar-remnants",
    dying_explosion = "radar-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    energy_per_sector = "25MJ", -- "10MJ",
    max_distance_of_sector_revealed = leighzermods.leighzerlongrangeradar.maxDistanceOfSectorRevealed, -- 28, -- 14,
    max_distance_of_nearby_sector_revealed = 1, -- 3,
    energy_per_nearby_scan = leighzermods.leighzerlongrangeradar.energyUsagekW .. "kJ", -- "250kJ",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = leighzermods.leighzerlongrangeradar.energyUsagekW .. "kW", -- "1MW", -- "300kW",
    integration_patch =
    {
      filename = "__base__/graphics/entity/radar/radar-integration.png",
      priority = "low",
      width = 119,
      height = 108,
      direction_count = 1,
      shift = util.by_pixel(1.5, 4),
      hr_version =
      {
        filename = "__base__/graphics/entity/radar/hr-radar-integration.png",
        priority = "low",
        width = 238,
        height = 216,
        direction_count = 1,
        shift = util.by_pixel(1.5, 4),
        scale = 0.5
      }
    },
    pictures =
    {
      layers =
      {
        {
          filename = "__leighzerlongrangeradar__/graphics/entity/long-range-radar/long-range-radar.png",
          priority = "low",
          width = 98,
          height = 128,
          apply_projection = false,
          direction_count = 64,
          line_length = 8,
          shift = util.by_pixel(1, -16),
          hr_version =
          {
            filename = "__leighzerlongrangeradar__/graphics/entity/long-range-radar/hr-long-range-radar.png",
            priority = "low",
            width = 196,
            height = 254,
            apply_projection = false,
            direction_count = 64,
            line_length = 8,
            shift = util.by_pixel(1, -16),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/radar/radar-shadow.png",
          priority = "low",
          width = 172,
          height = 94,
          apply_projection = false,
          direction_count = 64,
          line_length = 8,
          shift = util.by_pixel(39,3),
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__base__/graphics/entity/radar/hr-radar-shadow.png",
            priority = "low",
            width = 343,
            height = 186,
            apply_projection = false,
            direction_count = 64,
            line_length = 8,
            shift = util.by_pixel(39.25,3),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/radar.ogg",
          volume = 0.8
        }
      },
    max_sounds_per_type = 3,
    --audible_distance_modifier = 0.8,
    use_doppler_shift = false
    },
    radius_minimap_visualisation_color = { r = 0.059, g = 0.092, b = 0.235, a = 0.275 },
    rotation_speed = 0.01 / 2, -- 0.01,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/radar/radar-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 32,
        shift = util.by_pixel(5, 35),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  }
})

table.insert(data.raw.technology["military-3"].effects,{
  type = "unlock-recipe",
  recipe = "long-range-radar"
})