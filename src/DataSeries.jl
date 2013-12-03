module DataSeries

  import Base.show,
         Base.size,
         Base.length
         Base.getindex

  export SerialPair, 
         SerialArray,
         SerialFrame,   # not being implemented yet, just an idea
         head, 
         tail,
         first,
         last,
         @dataseries
  
  include("serialpair.jl")
  include("serialarray.jl")
  include("serialframe.jl")
  include("serialframe.jl")
  include("../test/testmacro.jl")
end
