[![Build Status](https://travis-ci.org/milktrader/DataSeries.jl.png)](https://travis-ci.org/milktrader/DataSeries.jl)

DataSeries.jl
=============

## Installation

````julia
julia> Pkg.clone("https://github.com/milktrader/DataSeries.jl")
````

## Proposed Goal

DataSeries is a simple, lightweight package that leverages Julia's Array 
methods to provide functionality important for working with serialized data. 
The primary mechanism to achieve this is the SeriesPair type, a tuple-like type 
with semantics that makes it easy to reason about serialized applications.

SeriesPair is immutable and includes two fields, index and value. When combined 
into an array, the resulting object becomes an Array{SeriesPair{T,V},1}, which 
enforces that each index in the array is the same type, and each value in the array 
is the same type.

DataSeries is an intermediary tool for working with Arrays of a base-defined types 
(e.g. Float64, Bool), and heterogeneous DataFrames. Conversion and promotion methods 
are planned to allow transition between the data structures.

To enforce the goal of simplicity, DataSeries only supports single column values.  Multiple 
columns can be attained by transitioning to an array of SeriesPair values, or to DataFrames.


## API
````julia
julia> using DataSeries

julia> foo = SeriesPair(1, 10); bar = SeriesPair(12, 15); baz = SeriesPair(4, 459);

julia> sa  = [foo, bar, baz]
 1  10
 12  15
 4  459

julia> sa[1]
1  10

julia> sa[2:end]
2-element Array{SeriesPair{Int64,Int64},1}:
 12  15
 4  459

julia> sort(sa)
1  10
4  459
12  15
````
