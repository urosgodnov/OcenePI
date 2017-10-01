#Grade assesment

comDF <- function(PP,ICTP,EP, mTV, mTP, mTK)
{
  #IzraÄun odstotkov
  vo<-round(PP/mTV*100,0)
  po<-round(ICTP/mTP*100,0)
  ko<-round(EP/mTK*100,0)
  
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

ocenatxt<- function(PP,ICTP,EP,mTV, mTP, mTK)
{
  gradeDF<-comDF(PP,ICTP,EP, mTV, mTP, mTK )
  
  val<-ifelse(gradeDF[gradeDF$Sklop=="Informacijska pismenost",3]=="Neopravljeno","C'mon, najprej opravite informacijsko pismenost, potem pa se bomo pogovarjali naprej!",NA)
  
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
    maxpoints=round(0.5*mTV+0.2*mTP+0.3*mTK,0)
    percentages<-round(points/(maxpoints)*100,0)
    
    ocena<-ifelse(percentages<60,5,
           ifelse(percentages<68,6,
           ifelse(percentages<76,7,
           ifelse(percentages<85,8,
           ifelse(percentages<93,9,10)))))
    
    val2<-paste("Skupaj ste dosegli ",as.character(points)," vseh tock od ",as.character(maxpoints),", kar znasa ",
                as.character(percentages)," odstotkov. Koncna ocena je tako ",
                as.character(ocena), "!",sep="")
    
    return(val2)
    
  }
              
  
  
  
}

comDFang <- function(PP,ICTP,EP, mTV, mTP, mTK)
{
  #IzraÄun odstotkov
  vo<-round(PP/mTV*100,0)
  po<-round(ICTP/mTP*100,0)
  ko<-round(EP/mTK*100,0)
  
  #Opravljeno/neopravljeno
  opv<-ifelse(vo>=50,"Passed","Failed")
  opo<-ifelse(po>=75,"Passed","Failed")
  oko<-ifelse(ko>=50,"Passed","Failed")
  
  # Compose data frame
  returnDF<-data.frame(
    Sklop = c("Homework", 
              "ICT",
              "Preexams"), 
    Odstotki=c(vo,po,ko),
    Opravljeno=c(opv,opo,oko),
    stringsAsFactors=FALSE)
  
  names(returnDF)<-c("Category","Percentages","Passed/not passed")
  
  return(returnDF)
  
  
}


ocenatxtang<- function(PP,ICTP,EP,mTV, mTP, mTK)
{
  gradeDF<-comDFang(PP,ICTP,EP, mTV, mTP, mTK )
  
  val<-ifelse(gradeDF[gradeDF$Category=="ICT",3]=="Failed","C'mon, concentrante on ICT test, then we will talk further!",NA)
  
  if (!is.na(val))
  {return(val)}
  
  val1<-ifelse(gradeDF[gradeDF$Category=="Homework",3]=="Failed","Due to not passing homewrok section, you'll have to take longer exam!",NA)
  
  if (!is.na(val1))
  {return(val1)}
  
  if(gradeDF[gradeDF$Category=="Preexams",2]<=30)
  { val2<-"Due to low score on preexams, you'll have to take longer exam! !"}
  else if (gradeDF[gradeDF$Category=="Preexams",2]<=50) {
    val2<-"You will have to take shorter exam!"
  } else {
    
    points<-round(PP*0.5+ICTP*0.2+EP*0.3,0)
    maxpoints=round(0.5*mTV+0.2*mTP+0.3*mTK,0)
    percentages<-round(points/(maxpoints)*100,0)
    
    ocena<-ifelse(percentages<60,5,
                  ifelse(percentages<68,6,
                         ifelse(percentages<76,7,
                                ifelse(percentages<85,8,
                                       ifelse(percentages<93,9,10)))))
    
    val2<-paste("Together you have reached ",as.character(points)," points of ",as.character(maxpoints),", which is ",
                as.character(percentages)," percentages. Final grade is ",
                as.character(ocena), "!",sep="")
    
    return(val2)
    
  }
  
  
  
  
}

