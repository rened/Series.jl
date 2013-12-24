module TestSeriesArray
  
  using Base.Test
  using Series
  
    sp1    = SeriesPair(1, 123)
    sp2    = SeriesPair(3, 789)
    sp3    = SeriesPair(2, 456)
    sp4    = SeriesPair(1, 44)
    sp5    = SeriesPair(3, 55)
    sp6    = SeriesPair(2, 66)
    sp7    = SeriesPair(4, 99)
    sa1    = [sp1, sp2, sp3]
    sa2    = [sp4, sp5, sp6, sp7]
    ss     = sort(sa1) # sort and isless
    arr    = Array(sa1,sa2)
    noNaN  = removenan(arr)
    saadd  = sa1 .+ sa2
    sasub  = sa1 .- sa2
    samult = sa1 .* sa2
    sadiv  = sa1 ./ sa2
  
  # sorting
    @test 456 == sa1[3].value 
    @test 789 == ss[3].value 
  
  # indexing
    @test sa1[1].index       == 1 # getindex
    @test sa1[1].value       == 123
    @test length(sa1[2:end]) == 2 # endof and length

  # construct Array of values
    @test size(arr)          == (4,2)
    @test sum(arr[2:end, 2]) == 220.0
    @test typeof(arr)        == Array{Float64, 2}
    @test isnan(arr[4, 1])   == true

  # remove rows that have NaN
    @test size(noNaN)       == (3,2)
    @test isnan(sum(noNaN)) == false

  # broacast operator
    @test saadd[1].value     == 167
    @test sasub1].value      == 79
    @test samult[1].value    == 5412
    @test sadiv[1].value     == 2.7954545454545454 
end
