function run!(model, game, gui=nothing)
    while !game_over!(game)
        model.real_time ? sleep(.5) : nothing
        decide!(model, game, gui)
    end
end

decide!(model::TwoDotsModel, game, gui) = throw("must implement decide! for model <: TwoDotsModel")