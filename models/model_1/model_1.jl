mutable struct Model <: TwoDotsModel 
    real_time::Bool 
end

Model(;real_time=false) = Model(real_time)

function decide!(model::Model, game, gui)
    options = search_all(game)
    n_dots = length.(options)
    _,idx = findmax(n_dots)
    choice = options[idx]
    select_choice!(model, game, gui, choice)
    model.real_time ? sleep(1) : nothing
    click_submit!(game, gui)
    return nothing
end

function select_choice!(model, game, gui, choice)
    for dot in choice
        click_dot!(game, dot, gui)
        model.real_time ? sleep(.5) : nothing
    end
end