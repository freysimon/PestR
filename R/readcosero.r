# read a COSERO output file

readcosero <- function(x){
  library(xts)

  qos <- read.table(x,header=TRUE,nrow=1)
  qos <- read.table(x,header=TRUE,
                  colClasses=c(rep("character",5),rep("numeric",ncol(qos)-5)))

  datum <- as.Date(paste(qos[,1],"-",qos[,2],"-",qos[,3],sep=""),format="%Y-%m-%d")

  qos <- xts(qos[,6:ncol(qos)],order.by=datum)

  return(qos)
}

