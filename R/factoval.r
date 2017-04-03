#########################################
#                                       #
# Umrechnung von Faktoren auf die       #
# Parameter für COSERO.                 #
# Für die Verwendung in PEST            #
#                                       #
#########################################

factoval <- function(file_in,file_out,GISfile,NB,upriverNB=NB){
  
  # Dateien einlesen
  GISfile <- read.table(GISfile,header=TRUE)
  facfile <- read.table(file_in,header=TRUE)
  para <- GISfile
  
  upriverNB <- c(NB,upriverNB)
  upriverNB <- unique(upriverNB)

  # Faktoren mit Parametern multiplizieren
  for(i in 4:ncol(GISfile)){
    name <- colnames(GISfile)[i]
    nb <- which(facfile[,1] %in% upriverNB)
    para[nb,i] <- GISfile[nb,i]*facfile[nb,which(name == colnames(facfile))]
  }
  
  # Ergebnistabelle für COSERO schreiben
  write.table(para,file=file_out,col.names=TRUE,row.names=FALSE,sep="\t",quote=FALSE)
}