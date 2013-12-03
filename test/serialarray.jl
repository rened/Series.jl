using Base.Test
using DataSeries

let
# dummy SerialArray
  sp1 = SerialPair(1, 123)
  sp2 = SerialPair(3, 789)
  sp3 = SerialPair(2, 456)
  sa  = SerialArray([sp1, sp2, sp3])

# index automatically sorted

  @assert 789 == sa[3].value # also tests getindex

# base like definitions
  @assert 3    == length(sa)
  @assert (3,) == size(sa)
  @assert 2    == length(sa[1:2]) # need more precise way to test getindex

end
