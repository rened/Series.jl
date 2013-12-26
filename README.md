[![Build Status](https://travis-ci.org/milktrader/Series.jl.png)](https://travis-ci.org/milktrader/Series.jl)

Series.jl
=============

## Installation

````julia
julia> Pkg.clone("https://github.com/milktrader/Series.jl")
````

## Proposed Goal

Series is a simple, lightweight package that leverages Julia's Array 
methods to provide functionality important for working with serialized data. 
The primary mechanism to achieve this is the `SeriesPair` type, a tuple-like type 
with semantics that makes it easy to reason about serialized applications.

`SeriesPair` is immutable and includes two fields, `index` and `value`. When combined 
into an array, the resulting object becomes an `Array{SeriesPair{T,V},1}`, which 
enforces that each index in the array is the same type, and each value in the array 
is the same type.

~~Series is an intermediary tool for working with Arrays of base-defined types 
(e.g. `Float64`, `Bool`), and heterogeneous DataFrames. Conversion and promotion methods 
are planned to allow transition between the data structures.~~

To enforce the goal of simplicity, Series only supports single column values.  Multiple 
columns can be attained by transitioning to an array of SeriesPair values, or to DataFrames.


## API
````julia
julia> using Series

# generic index 

julia> foo = SeriesArray([1:3], 5.*[1:3.])
3-element Array{SeriesPair{Int64,Float64},1}:
 1  5.0
 2  10.0
 3  15.0

julia> bar = SeriesArray([1:3], 10.*[1:3.])
3-element Array{SeriesPair{Int64,Float64},1}:
 1  10.0
 2  20.0
 3  30.0

julia> Array(foo, bar)
3x2 Array{Float64,2}:
  5.0  10.0
 10.0  20.0
 15.0  30.0

# using Datetime object as index

julia> op = readseries(Pkg.dir("Series/test/data/spx.csv"));

julia> cl = readseries(Pkg.dir("Series/test/data/spx.csv"), value=5);

julia> cl ./ op |> head
1-element Array{SeriesPair{Date{ISOCalendar},Float64},1}:
 1970-01-02  1.0102107321312188

julia> op |> percentchange |> removenan |> head
1-element Array{SeriesPair{Date{ISOCalendar},Float64},1}:
 1970-01-05  0.010210732131218946

julia> lag(cl)[1:2]
2-element Array{SeriesPair{Date{ISOCalendar},Float64},1}:
 1970-01-02  NaN
 1970-01-05  93.0
````
