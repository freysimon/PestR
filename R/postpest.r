
postpest <- function(NB,PESTfile="standard",outputfile=NULL){
  
  ###########################################################
  #                                                         #
  # Postprocessing für PEST Parameter Optimierung           #
  # Das Outputfile von PEST wird eingelesen und die         #
  # Parameter mittels einer Zuweisungstabelle geschrieben   #
  # Funktioniert mit Optimierung von PEST der Faktoren      #
  # der Parameter.                                          #
  #                                                         #
  ###########################################################
  
  

  # Enthaltene Parameter
  PP <- c("tab1","tvs1","tab2","tvs2","tab4","h1","h2","kbf","beta")
  
  if(PESTfile == "standard"){
    if(NB < 10){
      NBchar <- paste("0",NB,sep="")
    } else {
      NBchar <- NB
    }
    PESTfile <- paste("C:/PublicData/Drau/KAL/",NBchar,"/cosero_subbasin",NB,".rec",sep="")
  }
  
  if(is.null(outputfile)){
    outputfile <- paste("C:/PublicData/Drau/KAL/",NBchar,"_Parameter.txt",sep="")
  }
  
  temp <- readLines(PESTfile)
  for(i in 1:length(temp)){
    if(temp[i] == " Problem dimensions ----->"){
      pd <- i + 2
      end = as.numeric(strsplit(temp[pd],":",fixed=TRUE)[[1]][2])
      
    }
    if(temp[i] == " Optimised parameter values ----->"){
      start = i + 2
    }
  }
  
  parameters <- read.table(PESTfile, header=FALSE, skip=start, nrow=end,
                           colClasses=c("character","numeric"),stringsAsFactors=FALSE)
  
  parametername <- vector()
  klasse <- vector()
  for(k in 1:nrow(parameters)){
    temp <-  unlist(strsplit(parameters[k,1],"_"))
    parametername[k] <- temp[1]
    klasse[k] <- as.numeric(temp[3])
  }
  
  param <- matrix(nrow=10,ncol=length(PP),data=1)
  colnames(param) <- PP
  
  for(nr in 1:10){
    for(nc in 1:length(PP)){
      temp <- which(parametername == PP[nc] & klasse == nr)
      if(length(temp > 0))  param[nr,nc] <- parameters[temp,2]
    }
  }

  write.table(param,file=outputfile,sep="\t",quote=F,col.names = T,row.names=T)
}
