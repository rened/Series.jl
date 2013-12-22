module TestSeriesPair

  using Base.Test
  using Series

  a = SeriesPair(1, 33)
  b = SeriesPair(2, 22)
  c = SeriesPair(3, 11)

  @test a < b # not sure why this works 
  @test a.index == 1
  @test a.value == 33


end
