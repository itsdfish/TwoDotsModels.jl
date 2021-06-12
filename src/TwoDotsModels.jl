module TwoDotsModels
    import TwoDots: game_over!, is_adjecent, Dot, Game
    export TwoDotsModel, run!, game_over!, decide!, search_all, search
    export is_in_bounds, connected_dots, can_connect, color_matches

    include("structs.jl")
    include("functions.jl")
end
