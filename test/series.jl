a = Jig.Quant.op[1]
b = Jig.Quant.op[2]
c = Jig.Quant.op[3]

@context "values are correct for SeriesPair"
@jtest(
       a.value == 105.76
       )
@context "values are correct on operators"
@jtest( 
       (a + a).value == 211.52,
       (a - a).value == 0,
       (a * a).value == 11185.1776,
       (a / a).value == 1,
        a / b == nothing,                     # since indexes don't match, nothing is returned
        a < b)  # not sure why this works 
     
@context "dates are correct"
@jtest(
       a.index == Jig.Quant.firstday
       )

@context "types are correct"
@jtest(

       )



end
