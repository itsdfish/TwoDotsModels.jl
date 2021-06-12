function run!(model, game, gui=nothing)
    while !game_over!(game)
        model.real_time ? sleep(.5) : nothing
        decide!(model, game, gui)
    end
end

decide!(model::TwoDotsModel, game, gui) = throw("must implement decide! for model <: TwoDotsModel")

import TwoDots: is_adjecent

function search_all(game)
    moves = Vector{Vector{Dot}}()
    return mapreduce(x->search(game.dots, x), vcat, game.dots)
end

function search(dots, dot)
    sub_list = [dot]
    list = Vector{Vector{Dot}}()
    return search(dots, list, sub_list, dot.row, dot.col)
end

function search(dots, list, sub_list, r, c)
    branch = connected_dots(dots, sub_list, r, c)
    for dot in branch
        _sub_list = copy(sub_list)
        push!(_sub_list, dot)
        search(dots, list, _sub_list, dot.row, dot.col)
        push!(list, _sub_list)
    end
    return list
end

function connected_dots(dots, list, r, c)
    new_dots = Dot[]
    for i in -1:1
        for j in -1:1
            if can_connect(dots, list, r+j, c+i)
                push!(new_dots, dots[r+j,c+i])
            end
        end
    end
    return new_dots
end

function can_connect(dots, list, r, c)
    if !is_in_bounds(dots, r, c)
        return false 
    elseif in_set(dots[r,c], list)
        return false
    elseif !is_adjecent(list[end], dots[r,c])
        return false 
    elseif color_matches(dots[r,c], list[1])
        return true
    end
    return false
end

function is_in_bounds(dots, r, c)
    n_rows, n_cols = size(dots)
    return r > 0 && r ≤ n_rows && c > 0 && c ≤ n_cols
end    

color_matches(dot1, dot2) = dot1.color == dot2.color

function in_set(dot::Dot, dots)
    for d in dots 
        if d.row == dot.row && d.col == dot.col
            return true
        end
    end
    return false
end