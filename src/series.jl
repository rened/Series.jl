type Series
  index::Array
  values::Array
  nas::BitArray

  Series(x,y) = new(x,y,falses(length(x))
end
