module DataSeries

    export SerialPair, 
           SerialArray,
           SerialFrame  # not being implemented yet, just an idea

    include("serialpair.jl")
    include("serialarray.jl")
    include("serialframe.jl")
end
