module DataSeries

    export allna,
           anyna,
           each_failNA,
           each_removeNA,
           each_replaceNA,
           EachFailNA,
           EachRemoveNA,
           EachReplaceNA,
           failNA,
           isna,
           NA,
           NAException,
           NAtype,
           padNA,
           removeNA,
           replaceNA,

    include("dataseries.jl")
    include("natype.jl")
end
