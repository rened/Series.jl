using MarketData

@context "values are correct"

jtest( op[1].value  == 105.76,
      hi[1].value  == 106.08,
      lo[1].value  == 103.26,
      cl[1].value  == 105.22) 
     
@context "dates are correct"

jtest( op[1].index  == firstday, 
       hi[1].index  == firstday, 
       lo[1].index  == firstday, 
       cl[1].index  == firstday)
