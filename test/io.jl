@context "values are correct"
@jtest( 
#      op[1].value  == 105.76,
      Jig.Quant.op[1].value  == 105.76,
      Jig.Quant.hi[1].value  == 106.08,
      Jig.Quant.lo[1].value  == 103.26,
      Jig.Quant.cl[1].value  == 105.22) 
     
@context "dates are correct"
@jtest(
       Jig.Quant.op[1].index  == Jig.Quant.firstday, 
       Jig.Quant.hi[1].index  == Jig.Quant.firstday, 
       Jig.Quant.lo[1].index  == Jig.Quant.firstday, 
       Jig.Quant.cl[1].index  == Jig.Quant.firstday)
