[![Build Status](https://travis-ci.org/milktrader/DataSeries.jl.png)](https://travis-ci.org/milktrader/DataSeries.jl)

DataSeries.jl
=============

The three main types in this package include

* `SeriesPair` (an immutable type comprised of an index and value)
* ~~`SeriesArray` (an array of `SeriesPair` that enforces same index and value types)~~
* ~~`SeriesFrame` (a placeholder for possible future multi-column implementation)~~

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

julia> sa[1]
1  10

julia> sa[12]
ERROR: BoundsError()
 in getindex at /Users/Administrator/.julia/DataSeries/src/seriesarray.jl:60

julia> sa[[12]]
index  values
12  15

# future time series functionality

julia> using Datetime

julia> foo = SeriesPair(today(), 10); bar = SeriesPair(today()+days(1), 15); baz = SeriesPair(today()-days(1), 459);

julia> sa  = SeriesArray([foo, bar, baz])
index  values
2013-12-03  10
2013-12-04  15
2013-12-02  459

julia> sort(sa)
index  values
2013-12-02  459
2013-12-03  10
2013-12-04  15
````
