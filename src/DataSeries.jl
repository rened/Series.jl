module DataSeries

  import Base.show,
         Base.size,
         Base.length

  export SerialPair, 
         SerialArray,
         SerialFrame,   # not being implemented yet, just an idea
         head, 
         tail,
         first,
         last
  
  include("serialpair.jl")
  include("serialarray.jl")
  include("serialframe.jl")
end
