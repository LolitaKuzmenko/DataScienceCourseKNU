  getwd()
  setwd("Lab 5") ## setting the main directory
  getwd() ## checking out the true main directory
  filelist <- list.files(path="specdata", pattern=".csv", full.names=TRUE) ## getting file names
  length(filelist) ## checking the quantity of files (332)
  
    pmean <- function(directory, pollutant, id=1:332) {
    filelist <- list.files(path="specdata", pattern=".csv", full.names=TRUE)
    values <- numeric()
    for (i in id) {
      data <- read.csv(filelist[i])
      values <- c(values, data[[pollutant]])
    }
    mean(values, na.rm=TRUE)
  }                                       ##creating a function that calculates mean value for all csv files of "specdata" for 2 types of pollutant
  
    complete <- function(directory, id=1:332 ) {
    filelist <- list.files(path=directory, pattern=".csv", full.names=TRUE)
    nobs <- numeric()
    for (i in id) {
      data <- read.csv(filelist[i])
      nobs <- c(nobs, sum(complete.cases(data)))
    }
    data.frame(id, nobs)
  }                                       ##creating a function that calculates the number of completely observed cases for specified csv files of "specdata"
  
  corr <- function(directory, threshold = 0) {
    filelist <- list.files(path=directory, pattern=".csv", full.names=TRUE)
    corrsulfnitr <- c() 
    for(i in 1:length(filelist)){
      data <- read.csv(filelist[i])
      data <- data[complete.cases(data),]
      if ( nrow(data) > threshold ) {
        corrsulfnitr <- c(corrsulfnitr, cor(data$sulfate, data$nitrate) ) 
      }
    }
    return(corrsulfnitr)
  }                                       ##creating a function that calculates a correlation ratio between "sulfate" and "nitrate" for monitors, the number of complete observations for which is more than the threshold value.