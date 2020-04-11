for _,force in pairs(game.forces) do    
    
    if force.recipes["long-range-radar"] then
        force.recipes["long-range-radar"].enabled = force.technologies["military-3"].researched
    end   

end