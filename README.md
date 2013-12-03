DataSeries.jl
=============

The three main types in this package include

* `SeriesPair` (an immutable type comprised of an index and value)
* `SeriesArray` (an array of `SeriesPair` that enforces same index and value types)
* `SeriesFrame` (a placeholder for possible future multi-column implementation)

## Installation

````julia

julia> Pkg.clone("https://github.com/milktrader/DataSeries.jl")
````


## Current API
````julia
julia> using DataSeries

julia> foo = SeriesPair(1, 10); bar = SeriesPair(12, 15); baz = SeriesPair(4, 459);

julia> sa  = SeriesArray([foo, bar, baz])
index  values
1  10
12  15
4  459


julia> sort(sa)
index  values
1  10
4  459
12  15

````
