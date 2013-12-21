function readseries(filename::String; index=1, idxtype="date")
  
  anyarray = readcsv(filename)[2:end, :] # to take out the header
  idx      = anyarray[:, index]
  val      = anyarray[:, 2]              # just hard coded for now

  if  idxtype == "date" 
    idxarray = Date{ISOCalendar}[date(i) for i in idx] 
  else
    idxarray = Float64[i for i in idx]     # hard coded for now
  end

  valarray = Float64[v for v in val]

  Series(idxarray, valarray)
end
