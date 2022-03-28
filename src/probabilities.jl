DIRECTIONS = (
    ( 0,  1), # NE
    ( 1,  0), # E
    ( 1, -1), # SE
    ( 0, -1), # SW
    (-1,  0), # W
    (-1,  1), # NW
) #.|> x->HexTile(; hex=HexagonAxial(x...))

@enum Direction NE=1 E=2 SE=3 SW=4 W=5 NW=6

function adjacency_matrix(tiles)
    n = length(tiles)
    M = spzeros(n, n)
    for i in 1:n
        hex = tiles[i].hex
        for j in 1:n
            neighbor = tiles[j].hex
            if distance(hex, neighbor)==1
                M[i,j] = 1
            end
        end
    end
    return M
end

tile_dict(args...) = DefaultDict(0.0, args...)
tile_dict() = DefaultDict{HexagonAxial,Float64}(0.0)

maybe_change(dir, rules) = dir in keys(rules) ? rules[dir] : dir

function transition_probability(n_dice, rules=Dict{Direction,Direction}(); tiles=tile_dict(HexagonAxial(0,0)=>1.0))
    
    for _ in 1:n_dice
        new_tiles = tile_dict()
        for (pos, prob) in tiles
            for dir in (NE, E, SE, SW, W, NW)
                dir = maybe_change(dir, rules)
                dir_tup = DIRECTIONS[Int(dir)]
                # new_pos = pos .+ dir_tup
                new_pos = HexagonAxial(pos.q + dir_tup[1], pos.r + dir_tup[2])
                new_tiles[new_pos] += prob/6
            end
        end
        tiles = new_tiles
    end
    return tiles
    # return 
    # max_prob = maximum(values(tiles))
    # return map((pos,prob)->HexTile(HexagonAxial(pos...), RGB(prob/max_prob,0.0,0.0)), keys(tiles), values(tiles))
end

