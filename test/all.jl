using Jig

tally = 0
include("series.jl")
tally += fails

include("array.jl")
tally += fails
 
include("io.jl")
tally += fails

include("utilities.jl")
tally += fails

tally > 0 ? error("There are $tally failing tests in this suite") : nothing
