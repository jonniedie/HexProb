@kwdef @concrete struct HexTile
    hex<:Hexagon
    color = nothing
end

color(tile::HexTile) = tile.color