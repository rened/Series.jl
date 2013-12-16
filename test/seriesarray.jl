module TestSeriesArray

using Base.Test
using DataSeries
using DataFrames
using TimeSeries

#let
export convertSA, 
       convertArraytoSeriesArray

# dummy SeriesArray
  sp1 = SeriesPair(1, 123)
  sp2 = SeriesPair(3, 789)
  sp3 = SeriesPair(2, 456)
  sa  = SeriesArray([sp1, sp2, sp3])
  ss  = sort(sa)


# base like definitions
  @assert 3    == length(sa)
  @assert (3,) == size(sa)

# getindex
  @assert 123 == sa[1].value
  @assert 2   == length(sa[[1:2]])

# sorting
  @assert 456 == sa[3].value # no auto sorting provided
  @assert 789 == ss[3].value 

# convert DataFrame size n,2 to SeriesArray
  function convertArraytoSeriesArray{T,V}(a::Array{SeriesPair{T,V},1})
#  function convertArraytoSeriesArray(a)

 
    #capture types
    spT = typeof(a[1].index)
    spV = typeof(a[1].value)
    container = SeriesPair{spT, spV}[]

    for i in 1:length(a)
      push!(container, SeriesPair(a[i].index, a[i].value))
    end

    SeriesArray(container)
  end
  
  function convertSA(df::DataFrame; idx=1, val=2)
    spT = typeof(df[1,idx])
    spV = typeof(df[1,val])
    container = SeriesPair{spT, spV}[]
    for i in 1:size(df,1)
      push!(container, SeriesPair(df[i,idx], df[i,val]))
    end
    # container is now Array{SeriesPair{T,V},1}
    # next step is to convert this to SeriesArray
    # this allows methods to be defined on the object (such as sort)

  #  convertArraytoSeriesArray(container)
  end

  spx = readtime(Pkg.dir("TimeSeries/test/data/spx.csv"))

  #foo = convertSA(spx,idx=1,val=2)
  foo = convertSA(spx)


  #@test 507 == length(foo)
  
end
