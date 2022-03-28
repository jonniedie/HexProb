function Shape(hex::HexTile)
    verts = vertices(hex.hex)
    return Shape(first.(verts), last.(verts))
end

@recipe function f(::Type{T}, hex::T) where {T<:HexTile}
    aspectratio --> 1
    if !isnothing(hex.color)
        color --> hex.color
    end
    return Shape(hex)
end

@recipe function f(::Type{T}, hexes::T) where {T<:AbstractArray{<:HexTile}}
    aspectratio --> 1
    primary := false
    color --> [hex.color for hex in hexes] |> permutedims
    linealpha --> 0
    Shape.(hexes)
end

function prob_plot(args...; linealpha=0, kwargs...)
    tiles = transition_probability(args...)
    max_prob = maximum(values(tiles))
    tiles = map((hex,prob)->HexTile(hex, RGB(prob/max_prob,0.0,0.0)), keys(tiles), values(tiles))
    plot(tiles; linealpha, showaxis=false, ticks=false, grid=false, backgroundinside=:black, kwargs...)
    plot!(HexTile(hex=HexagonAxial(0,0)); fillalpha=0.0, linecolor=:lightgreen, linewidth=2, label="aim point")
end