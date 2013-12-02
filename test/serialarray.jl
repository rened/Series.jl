using Base.Test
using DataSeries

let
# dummy SerialArray
  sp1 = SerialPair(1, 123)
  sp2 = SerialPair(2, 456)
  sp3 = SerialPair(3, 789)
  sa  = SerialArray([sp1, sp2, sp3])

# base like definitions
  @assert 3    == length(sa)
  @assert (3,) == size(sa)

end
