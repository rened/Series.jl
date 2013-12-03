using Base.Test
using DataSeries

let
# dummy SerialArray
  sp1 = SerialPair(1, 123)
  sp2 = SerialPair(3, 789)
  sp3 = SerialPair(2, 456)
  sa  = SerialArray([sp1, sp2, sp3])
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

end
