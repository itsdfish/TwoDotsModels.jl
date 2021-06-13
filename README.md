# TwoDotsModels

This package contains basic functions for developing simulated agents that play the game [TwoDots](https://github.com/itsdfish/TwoDots.jl). The simulated agents can play the game with the GUI visible, or turned off. 

# Example

I will provide a simple example in which the agent selects the largest set of dots on each trial. Note that this agent is far from optimal because it does not look ahead to find rectangles, which tend to provide the most points. The stand-alone code associated with this example can be found in `models/model_1`. 

## Installation 
The first step is to install the package with `] add TwoDotsModels` or `] dev TwoDotsModels` for development. 


## Load Dependencies

Load TwoDotsModels and import the function `decide!` so that it can be extended for this specific model.

```julia 
using  TwoDotsModels
import TwoDotsModels: decide!
````
## Define Model

Define a model object that is a subtype of `TwoDotsModel`. At minimum, the model must contain the field `real_time`, which runs the model in real time if true. 

```julia
mutable struct Model <: TwoDotsModel 
    real_time::Bool 
end

Model(;real_time=false) = Model(real_time)
````

## Define decide!

Below, I will define a decide! function for the model. The function `search_all` returns all connectable
sets of dots. In the model, the largest set of connectable dots is assigned to the variable `choice`. `select_choice!` is a custom function that iterates through each dot in `choice` and clicks on it (see below). `click_submit` is a function that processes the choice, updates the score, and replaces the selected dots with new dots.   

```julia
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
```

As described above, `select_choice!` clicks on each dot in `choice` followed by a pause if `real_time` is true. 

````julia
function select_choice!(model, game, gui, choice)
    for dot in choice
        click_dot!(game, dot, gui)
        model.real_time ? sleep(.5) : nothing
    end
end
````

## Run Simulation with the GUI

The following code block illustrates how to run the simulated agent with the GUI. First, an instance of `Model` is produced with `real_time` set to true. Second, an instance of a game is generated with default parameters. Next, an instance of the gui is defined based on the game object. Finally, `model`, `game` and `gui` are passed to the function `run!`.

```julia
model = Model(;real_time = true)
game = Game()
gui = GUI(;game)
run!(model, game, gui)
````

## Run Simulation without the GUI

The simulated agent can be ran without the GUI simply by ommitting the gui object. The default value of `real_time` is false, which means the simulated game will run as quickly as possible. If you want to run without the GUI in real-time, you can set `real_time` to true.

```julia
model = Model()
game = Game()
run!(model, game)
````