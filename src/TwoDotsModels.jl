module TwoDotsModels
    export TwoDotsModel, run!, game_over!, decide!
    import TwoDots: game_over!, is_adjecent

    include("structs.jl")
    include("functions.jl")
end
