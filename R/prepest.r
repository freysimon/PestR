###########################################################
#                                                         #
# Erstellt ein PEST Control file                          #
# Dazu muss PEST (Modelindependent Parameter Estimation   #
# Tool, Watermark Numerical Comuputing) auf dem PC        #
# installiert sein und folgende Executables müssen sich   #
# im selben Verzeichnis befinden, in dem diese R-Funktion #
# ausgeführt wird:                                        #
# - tempchek.exe                                          #
# - pestgen.exe                                           #
#                                                         #
# NB bezeichnet das gewünschte Subbasin (nur das          #
# flussab gelegene Subbasin!), upriverNB bezeichnet die   #
# flussaufwärts gelegenen Subbasins. Sowohl NB als auch   #
# upriverNB werden optimiert!                             #
# Wenn updatesofar = TRUE, wird zuerst eine               #
# Parametertabelle geladen, welche die bereits            #
# optimierten Parameter (z.B. von früheren Läufen)        #
# enthält. Dies ist sinnvoll, falls das Skript Teil eines #
# Batchfiles ist und ein Flußgebiet Schritt für Schritt   #
# kalibriert werden soll                                  #
#                                                         #
# BASEPAR bezeichnet die Datei mit den Ausgangsparametern #
# Für weiter flußabgelegene Subeinzugsgebiete sollte      #
# BASEPAR aktualisert werden, da sonst die obengelgenen   #
# Gebiete mit nicht-optimierten Parametern berchentet     #
# werden.                                                 #
#                                                         #
# Autor: Simon Frey                                       #
# Version: 1.2                                            #
# Datum: November 2016                                    #
#                                                         #
###########################################################

prepest <- function(NB,upriverNB=NA,updateparasofar=FALSE,BASEPAR=NULL){
  
  # Letzte n Buchstaben eines Characters auswerten
  substrRight <- function(x, n){
    substr(x, nchar(x)-n+1, nchar(x))
  }
  
  
  if(is.null(BASEPAR)){
    stop("BASEPAR muss angegeben werden. Dabei handelt es sich um die Matrix mit den Ausgangsparametern.")
  }
  
  if(NB < 10){
    NBchar <- paste("0",NB,sep="")
  } else {
    NBchar <- as.character(NB)
  }
  setwd(paste("C:/PublicData/Drau/KAL/",NBchar,sep=""))
  
  if(updateparasofar){
    new <- read.table("input/best_para_sofar.txt",header=TRUE)
    old <- read.table("C:/PublicData/Drau/PEST/best_para_sofar.txt",header=TRUE)
    
    old[old[,4]!=new[,4],] <- new[old[,4]!=new[,4],]
    
    write.table(old, "C:/PublicData/PEST/Drau/best_para_sofar.txt",col.names=TRUE,row.names=FALSE,quote=FALSE,sep="\t")
  }
  
  #Platzhalter einlesen
  PP <- read.table("C:/PublicData/Drau/PEST/Platzhalter.txt",header=TRUE,nrow=1)
  NCPP <- ncol(PP)-3
  PP <- read.table("C:/PublicData/Drau/PEST/Platzhalter.txt",header=TRUE,colClasses=c(
    rep("numeric",3),rep("character",NCPP)
  ))
  
  BASEPAR <- read.table(BASEPAR,header=TRUE,colClasses="numeric")
  
  if(is.na(upriverNB[1])){
#     upriverNB <- NB
     factofileNB <- NB
  } else {
     if(length(upriverNB) > 1){
       for(i in 1:length(upriverNB)){
         if(i == 1){
           factofileNB <- upriverNB[i]
         } else{
           factofileNB <- paste(factofileNB,upriverNB[i],sep=",")
         }
       }
     } else {
       factofileNB <- upriverNB
     }
     upriverNB <- c(NB,upriverNB)
  }
  if(is.na(upriverNB[1])){
    PPsub <- PP[PP[,1] %in% NB,]
    
  } else {
    PPsub <- PP[PP[,1] %in% upriverNB,]
    
  }
  # underline hinzufügen, falls noch keine hinzugefügt ist
  colnames(PPsub) <- paste(colnames(PPsub),ifelse(substrRight(colnames(PPsub),1) != "_","_",""),sep="")
    
  
  for(i in 4:(NCPP+3)){
    PPsub[,i] <- paste("@",PPsub[,i],"     @",sep="")
  }
  
  if(!is.na(upriverNB[1])){
    BASEPAR[PP[,1] %in% upriverNB,] <- PPsub
    for(n in 2:length(upriverNB)){
      for(i in 4:ncol(BASEPAR)){
        for(k in 1:nrow(BASEPAR)){
          BASEPAR[k,i] <- gsub(paste("_",upriverNB[n],"_",sep=""),paste("_",NB,"_",sep=""),BASEPAR[k,i])
        }
      }
    }
  } else {
    BASEPAR[PP[,1] %in% NB,] <- PPsub
#    for(i in 4:ncol(BASEPAR)){
#      for(k in 1:nrow(BASEPAR)){
#        BASEPAR[k,i] <- gsub(paste("_",NB,sep=""),"",BASEPAR[k,i])
#      }
#    }
  }
    

  
  writeLines("ptf @",con="in.tpl")
  write.table(BASEPAR,"in.tpl",row.names=FALSE,col.names=TRUE,sep="\t",quote=FALSE,append=TRUE)
  
  tempchek <- paste(getwd(),"/tempchek.exe in.tpl",sep="")
  system(tempchek,wait=TRUE)
  
  paras <- read.table("in.pmt",colClasses="character")
  paras <- sort(paras[,1])
  
  paras <- cbind(paras,1,"1.0","0.0")
  writeLines("single point",con="in.par")
  write.table(paras,"in.par",row.names=FALSE,col.names=FALSE,sep="\t",quote=FALSE,append=TRUE)
  
  pestgen <- paste(getwd(),"/pestgen.exe cosero_subbasin",NB," in.par measure.obf",sep="")
  system(pestgen,wait=TRUE)
  
  # batchfile schreiben
  writeLines(c(paste("cd C:\\PublicData\\Drau\\KAL\\",NBchar,sep=""),
               paste('"C:\\Program Files\\R\\R-3.2.3\\bin\\Rscript.exe" ',
                   '"C:\\PublicData\\Drau\\KAL\\',NBchar,'\\commands_factofile.txt"',sep=""),
               paste("COSERO.exe < commands_paraload.txt",sep=""),
               paste("copy /Y C:\\PublicData\\Drau\\KAL\\",NBchar,
                     "\\output\\Parameter_COSERO.par C:\\PublicData\\Drau\\KAL\\",NBchar,
                     "\\input\\Parameter_COSERO.par",sep=""),
               paste("COSERO.exe < commands_singlerun.txt",sep=""),
               paste('"C:\\Program Files\\R\\R-3.2.3\\bin\\Rscript.exe" ',
                     '"C:/PublicData/Drau/KAL/',NBchar,'/commands_kge_nse.txt"',sep="")
              ),
              con="COSERO_single_run.bat")
  
  # commands_factofile schreiben
  writeLines(c('source("C:/PublicData/Drau/PEST/factoval.r")',
             paste('factoval(file_in = "C:/PublicData/Drau/KAL/',NBchar,'/PEST_Para.txt",',sep=""),
             paste('file_out = "C:/PublicData/Drau/KAL/',NBchar,'/input/PEST_Paraload.txt",',sep=""),
             paste('GISfile = "C:/PublicData/Drau/PEST/Baseparameters.txt",',sep=""),
             paste("NB=",NB,",",sep=""),
             paste("upriverNB=c(",factofileNB,"))",sep="")),
             con="commands_factofile.txt")
  
  PST <- readLines(paste("cosero_subbasin",NB,".pst",sep=""))
  
  # Block mit parameter data suchen und neu einlesen als data.frame
  for(i in 1:length(PST)){
    if(PST[i] == "* parameter data"){
      start_par = i
    }
    if(PST[i] == "* observation groups"){
      stop_par = i-1
      start_modelcommand = i+4
    }
  }
  
  paradata <- read.table(paste("cosero_subbasin",NB,".pst",sep=""),header=FALSE,
                         skip=start_par,nrow=stop_par-start_par, colClasses="character")
  
  paradata[,5] <- 0.3
  paradata[,6] <- 3.0
  pd <- paste(paradata[,1],paradata[,2],paradata[,3],paradata[,4],paradata[,5],paradata[,6],paradata[,7],
              paradata[,8],paradata[,9],paradata[,10],sep="  ")
  PST[(start_par+1):stop_par] <- pd
  
  PST[start_modelcommand+1] <- "COSERO_single_run.bat"
  PST[start_modelcommand+3] <- "in.tpl   PEST_Para.txt"
  PST[start_modelcommand+4] <- "out.ins  output\\kge_nse.txt"
  
  writeLines(PST,con=paste("cosero_subbasin",NB,".pst",sep=""))
  
}

