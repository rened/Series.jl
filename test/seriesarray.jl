module TestSeriesArray
  
  using Base.Test
  using DataSeries
  
    sp1 = SeriesPair(1, 123)
    sp2 = SeriesPair(3, 789)
    sp3 = SeriesPair(2, 456)
    sa  = [sp1, sp2, sp3]
  
  # sorting
    ss  = sort(sa) # sort and isless
    @test 456 == sa[3].value 
    @test 789 == ss[3].value 
  
  # indexing
    @test sa[1].index == 1 # getindex
    @test sa[1].value == 123
    @test length(sa[2:end]) == 2 # endof and length

end
