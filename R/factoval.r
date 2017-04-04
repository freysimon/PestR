#########################################
#                                       #
# Umrechnung von Faktoren auf die       #
# Parameter für COSERO.                 #
# Für die Verwendung in PEST            #
#                                       #
#########################################

factoval <- function(file_in,file_out,transferfile,NB,upriverNB=NB){

  # Dateien einlesen
  transferfile <- read.table(transferfile,header=TRUE)
  facfile <- read.table(file_in,header=TRUE)
  para <- transferfile

  upriverNB <- c(NB,upriverNB)
  upriverNB <- unique(upriverNB)

  # Faktoren mit Parametern multiplizieren
  for(i in 4:ncol(transferfile)){
    name <- colnames(transferfile)[i]
    nb <- which(facfile[,1] %in% upriverNB)
    para[nb,i] <- transferfile[nb,i]*facfile[nb,which(name == colnames(facfile))]
  }

  # Ergebnistabelle für COSERO schreiben
  write.table(para,file=file_out,col.names=TRUE,row.names=FALSE,sep="\t",quote=FALSE)
}
