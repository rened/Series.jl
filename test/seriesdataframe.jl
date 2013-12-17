module TestSeriesDataFrame
  using Base.Test
  using DataSeries

  ### # convert DataFrame size n,2 to SeriesArray
  ###   
  ###   function convertSA(df::DataFrame; idx=1, val=2)
  ###     spT = typeof(df[1,idx])
  ###     spV = typeof(df[1,val])
  ###     container = SeriesPair{spT, spV}[]
  ###     for i in 1:size(df,1)
  ###       push!(container, SeriesPair(df[i,idx], df[i,val]))
  ###     end
  ### 
  ###   end

end
