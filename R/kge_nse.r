# Designed to read a COSERO outputfile

kge_nse <- function(x,simcol=2,
                    OUT = "kge_nse.txt",
                    from = NULL, to = NULL){
  # libraries laden
  require(hydroGOF)
  require(xts)

  if(!any(is.null(c(from,to)))){
    x <- x[paste(from,"/",to,sep="")]
  }
  if(is.null(from) & !is.null(to)){
    x <- x[paste(from,"/",sep="")]
  }
  if(!is.null(from) & is.null(to)){
    x <- x[paste("/",to,sep="")]
  }


  nse <- NSE(sim=x[,simcol],obs=x[,simcol-1])
  kge <- KGE(sim=x[,simcol],obs=x[,simcol-1])

  out <- t(data.frame(KGE = kge, NSE = nse))


 # write.table(rbind(nse,kge),file="kge_nse.txt",col.names=TRUE,row.names=TRUE,quote=FALSE,sep="\t")
  if(!is.null(OUT)) {
    write.table(out*(-1),file=OUT,col.names=FALSE,row.names=FALSE,quote=FALSE,sep="\t")
  }
  print(out)
  print("----------------------------------------")
  print(paste("file write to",pfad,"OK",sep=" "))
}



