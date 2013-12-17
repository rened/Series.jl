module DataSeries

  import Base.show,
         Base.isless

  export SeriesPair, 
         head, 
         tail,
         first,
         last,
         @dataseries
  
  include("seriespair.jl")
  include("seriesarray.jl")
  include("seriesdataframe.jl")
  include("../test/testmacro.jl")
end
