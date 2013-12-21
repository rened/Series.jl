module TestIO

using Base.Test
using DataSeries
using Datetime

  open  = readseries(Pkg.dir("DataSeries/test/data/spx.csv"))
  high  = readseries(Pkg.dir("DataSeries/test/data/spx.csv"), value= 3)
  low   = readseries(Pkg.dir("DataSeries/test/data/spx.csv"), value= 4)
  close = readseries(Pkg.dir("DataSeries/test/data/spx.csv"), value= 5)

  

end
