using SafeTestsets

@safetestset "Recursive Search" begin
    using TwoDotsModels, TwoDots, Test
    game = Game()
    map(x->x.color = "green", game.dots)
    game.dots[1,1].color = "red"
    game.dots[2,1].color = "red"
    game.dots[2,2].color = "red"
    game.dots[2,3].color = "red"

    game.dots[3,1].color = "red"
    game.dots[4,1].color = "red"
    game.dots[4,2].color = "red"
    game.dots[4,3].color = "red"
    options = search(game.dots, game.dots[1,1])

    check(dot, r, c) = dot.row == r && dot.col == c
    indices = [
        (1,1),
        (2,1),
        (3,1),
        (4,1),
        (4,2),
        (4,3)
    ]
    @test map((v,t)->check(v, t...), options[1], indices) |> all

    indices = [
        (1,1),
        (2,1),
        (3,1),
        (4,1),
        (4,2),
    ]
    @test map((v,t)->check(v, t...), options[2], indices) |> all

    indices = [
        (1,1),
        (2,1),
        (3,1),
        (4,1),
    ]
    @test map((v,t)->check(v, t...), options[3], indices) |> all

    indices = [
        (1,1),
        (2,1),
        (3,1),
    ]
    @test map((v,t)->check(v, t...), options[4], indices) |> all

    indices = [
        (1,1),
        (2,1),
        (2,2),
        (2,3),
    ]
    @test map((v,t)->check(v, t...), options[5], indices) |> all

    indices = [
        (1,1),
        (2,1),
        (2,2),
    ]
    @test map((v,t)->check(v, t...), options[6], indices) |> all

    indices = [
        (1,1),
        (2,1),
    ]
    @test map((v,t)->check(v, t...), options[7], indices) |> all

    @test length(options) == 7
end
