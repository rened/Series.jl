module TestIO

using Base.Test
using DataSeries
using Datetime

  open  = readseries(Pkg.dir("DataSeries/test/data/spx.csv"))
  high  = readseries(Pkg.dir("DataSeries/test/data/spx.csv"), value= 3)
  low   = readseries(Pkg.dir("DataSeries/test/data/spx.csv"), value= 4)
  close = readseries(Pkg.dir("DataSeries/test/data/spx.csv"), value= 5)

  @ test open[1].value  == 92.06
  @ test high[1].value  == 93.54
  @ test low[1].value   == 91.79
  @ test close[1].value == 93.0

  @ test open[1].index  == date(1970, 1,2) 
  @ test high[1].index  == date(1970, 1,2) 
  @ test low[1].index   == date(1970, 1,2) 
  @ test close[1].index == date(1970, 1,2) 

end
