#Grade assesment

comDF <- function(PP,ICTP,EP)
{
  #Izračun odstotkov
  vo<-round(PP/70*100,0)
  po<-round(ICTP/20*100,0)
  ko<-round(EP/42*100,0)
  
  #Opravljeno/neopravljeno
  opv<-ifelse(vo>=50,"Opravljeno","Neopravljeno")
  opo<-ifelse(po>=75,"Opravljeno","Neopravljeno")
  oko<-ifelse(ko>=50,"Opravljeno","Neopravljeno")
  
  # Compose data frame
  return(data.frame(
    Sklop = c("Vaje", 
              "Informacijska pismenost",
              "Kolokvija"), 
    Odstotki=c(vo,po,ko),
    Opravljeno=c(opv,opo,oko),
    stringsAsFactors=FALSE))
  
  
}

ocenatxt<- function(PP,ICTP,EP)
{
  gradeDF<-comDF(PP,ICTP,EP)
  
  val<-ifelse(gradeDF[gradeDF$Sklop=="Informacijska pismenost",3]=="Neopravljeno","Najprej morate opraviti informacijsko pismenost!",NA)
  
  if (!is.na(val))
  {return(val)}
      
  val1<-ifelse(gradeDF[gradeDF$Sklop=="Vaje",3]=="Neopravljeno","Ker nimate opravljenih vaj, vas caka daljsi pisni izpit!",NA)
  
  if (!is.na(val1))
  {return(val1)}
  
  if(gradeDF[gradeDF$Sklop=="Kolokvija",2]<=30)
  { val2<-"Zaradi majhnega stevila tock pri kolokviju, vas caka daljsi pisni izpit!"}
  else if (gradeDF[gradeDF$Sklop=="Kolokvija",2]<=50) {
    val2<-"Caka vas krajsi pisni izpit!"
  } else {
    
    points<-round(PP*0.5+ICTP*0.2+EP*0.3,0)
    percentages<-round(points/(51.6)*100,0)
    
    ocena<-ifelse(percentages<60,5,
           ifelse(percentages<68,6,
           ifelse(percentages<76,7,
           ifelse(percentages<85,8,
           ifelse(percentages<93,9,10)))))
    
    val2<-paste("Skupaj ste dosegli ",as.character(points)," tock, kar znasa ",
                as.character(percentages)," odstotkov. Koncna ocena je tako ",
                as.character(ocena), "!",sep="")
    
    return(val2)
    
  }
              
  
  
  
}
