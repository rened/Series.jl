module TestSeriesArray
  
  using Base.Test
  using Series
  
    sa1, sa2 = SeriesPair{Int, Float64}[],  SeriesPair{Int, Float64}[]
    for ind in [2,1,3]
      push!(sa1, SeriesPair(ind, float(10ind)))
      push!(sa2, SeriesPair(ind, float(5ind)))
    end
    sa3 = [sa2, SeriesPair(4, 99.)]

    ss     = sort(sa1) # sort and isless
    arr    = Array(sa1,sa3)
    noNaN  = removenan(arr)
    saadd  = sa1 .+ sa2
    sasub  = sa1 .- sa2
    samult = sa1 .* sa2
    sadiv  = sa1 ./ sa2
  
  # sorting
    @test 20  == sa1[1].value 
    @test 10  == ss[1].value 
  
  # indexing
    @test sa1[1].index       == 2 # getindex
    @test sa1[1].value       == 20
    @test length(sa1[2:end]) == 2 # endof and length

  # construct Array of values
    @test size(arr)          == (4,2)
    @test sum(arr[2:end, 2]) == 124.0
    @test typeof(arr)        == Array{Float64, 2}
    @test isnan(arr[4, 1])   == true

  # remove rows that have NaN
    @test size(noNaN)       == (3,2)
    @test isnan(sum(noNaN)) == false

  # broacast operator 
  # CAUTION: sorting NOT enforced
  # TODO: enforce sorting
  
    @test saadd[1].value   == 30.
    @test sasub[1].value   == 10.
    @test samult[1].value  == 200.
    @test sadiv[1].value   == 2.0

  # heads and tails
    @test length(head(sa1)) == 1
    @test length(tail(sa2)) == 2
    @test head(sa1)[1].value   == 20
end
