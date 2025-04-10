module TestTidierFiles

using TidierFiles
using Test
using Documenter
#=
DocMeta.setdocmeta!(TidierFiles, :DocTestSetup, :(begin
    using DataFrames, TidierFiles
end); recursive=true)

doctest(TidierFiles)
=#

@testset "JSON Test" begin
    
    function roundTripDataFrame(df::DataFrame; JSONObjectVector=true)
        write_json(df, "testdf.json";JSONObjectVector )
        df_read = read_json("testdf.json")
        return isequal(df, df_read) 
    end
    
 
    df_anscombe = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/anscombe.json")

    @test typeof(df_anscombe.X) == Vector{Float64}

    @test roundTripDataFrame(df_anscombe, JSONObjectVector = false)

    df_barley = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/barley.json")

    @test typeof(df_barley.yield) == Vector{Float64}

    @test roundTripDataFrame(df_barley;JSONObjectVector=false)

    df_budget = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/budget.json")

    @test roundTripDataFrame(df_budget)

    df_budgets = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/budgets.json")

    @test roundTripDataFrame(df_budgets)
    @test typeof(df_budgets.value) == Vector{Float64}
    @test typeof(df_budgets.budgetYear) == Vector{Int64}


    df_burtin = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/burtin.json")

    @test roundTripDataFrame(df_burtin)

    df_cars = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/cars.json")

    @test sum(skipmissing(df_cars.Horsepower)) == 42033

    @test roundTripDataFrame(df_cars)

    df_countries = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/countries.json")

    @test sum(skipmissing(df_countries.p_life_expect))  ≈ 36591.29 atol=0.01

   
    df_crimea = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/crimea.json")

    @test roundTripDataFrame(df_crimea)

    df_driving = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/driving.json")

    @test roundTripDataFrame(df_driving)

   
    df_flights_200k = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/flights-200k.json")

    @test roundTripDataFrame(df_flights_200k)

    df_football = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/football.json")

    @test roundTripDataFrame(df_football)

    df_income = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/income.json")

    @test roundTripDataFrame(df_income)

    df_jobs = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/jobs.json")

    @test roundTripDataFrame(df_jobs)


    df_movies = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/movies.json")

    @test roundTripDataFrame(df_movies)

    df_obesity = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/obesity.json")

    @test sum(df_obesity.rate) ≈ 7.791 atol=0.01

    df_ohlc = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/ohlc.json")

    @test sum(df_ohlc.open) ≈ 1223.04 atol=0.01
 
    df_penguins = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/penguins.json")

    @test sum(skipmissing(df_penguins."Flipper Length (mm)")) == 68713

    @test roundTripDataFrame(df_penguins)


    df_platformer_terrain = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/platformer-terrain.json")

    df_political_contributions = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/political-contributions.json")

    df_population = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/population.json")

    df_udistrict = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/udistrict.json")

    df_unemployment = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/unemployment-across-industries.json")

    @test roundTripDataFrame(df_unemployment)


    df_uniform_2d = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/uniform-2d.json")

    df_uniform_2d = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/us-10m.json")

    df_us_state_capitals = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/us-state-capitals.json")

    @test roundTripDataFrame(df_us_state_capitals)

    @test sum(df_us_state_capitals.lat) ≈ 1970.67 atol=0.01

    #df_volcano = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/volcano.json")

    df_weekly_weather = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/weekly-weather.json")


    #=
    df_weekly_weather_without_missing=dropmissing(df_weekly_weather, :forecast)

    df_weekly_weather_unnested=@unnest_wider(df_weekly_weather_without_missing, normal, record, forecast)
    sum(skipmissing(df_weekly_weather_unnested.forecast_high))

    df_weekly_weather_unnested2=@unnest_wider(df_weekly_weather, normal, record, forecast)
    sum(skipmissing(df_weekly_weather_unnested2.forecast_high))
    =#

    df_wheat = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/wheat.json")

    @test sum(skipmissing(df_wheat.wages)) ≈ 579.08 atol=0.01

    @test typeof(df_wheat.wheat) == Vector{Float64}

    @test roundTripDataFrame(df_wheat)


    end


end

