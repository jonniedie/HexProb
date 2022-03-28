module HexProb

using Base: @kwdef
using ConcreteStructs: @concrete
using DataStructures: DefaultDict
using Hexagons: Hexagons, Hexagon, HexagonAxial, vertices, distance
using Plots: Shape, RGB, plot, plot!
using RecipesBase: RecipesBase, @recipe, @series
using SparseArrays: spzeros


include("hextile.jl")
export HexTile

include("probabilities.jl")
export transition_probability, NE, E, SE, SW, W, NW

include("plotting.jl")
export prob_plot


end
