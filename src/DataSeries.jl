module DataSeries

  import Base.show,
         Base.size,
         Base.length
         Base.getindex
         Base.sort

  export SeriesPair, 
         SeriesArray,
         SeriesArray1,
         SeriesFrame,   # not being implemented yet, just an idea
         sortindex, 
         getindexMAGIC, 
         insertpair, 
         head, 
         tail,
         first,
         last,
         @dataseries
  
  include("seriespair.jl")
  include("seriesarray.jl")
  include("seriesframe.jl")
  include("seriesframe.jl")
  include("../test/testmacro.jl")
end
