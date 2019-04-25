Для лабораторної роботи необхідно завантажити zip файл з даними за
посиланням:
  «https://www.dropbox.com/s/i9wi47oyhfb7qlh/rprog_data_specdata.zip?dl=0».
  Це файл містить 332 csv файлів, що містять у собі результати спостережень за
  забрудненням повітря дрібнодисперсними частками (fine particular matter air
                                                   pollution) у 332 локаціях у США. Кожен файл містить дані з одного монітору. ID
  номер кожного монітору міститься у назві файлу. Наприклад, дані з монітору
  під номером 200 містяться у файлі «200.csv». Кожен файл містить три змінні:
    Data: дата спостереження в форматі (рік-місяць-день), sulfate: рівень
  сульфатних часток в повітрі на дату (мікрограми на кубічний метр) та nitrate:
    рівень нітратних часток в повітрі на дату (мікрограми на кубічний метр). Для цій
  роботи необхідно додати на Github файл pmean.R, який містить усі функції. В
  файлі md необхідно указати виклик функції з аргументами та вивід у консоль
  результатів роботи функцій.
  1. Написати функцію pmean, яка обчислює середнє значення (mean)
  забруднення сульфатами або нітратами серед заданого переліка
  моніторів. Ця функція приймає три аргументи: «directory», «pollutant»,
  «id». Directory – папка, в якій розміщені дані, pollutant – вид забруднення,
  id – перелік моніторів. Аргумент id має значення за замовчуванням 1:332.
  Функція повинна ігнорувати NA значення. Приклад роботи функції:
    pmean("specdata", "sulfate", 1:10)
  ## [1] 4.064128
  pmean("specdata", "sulfate", 55)
  ## [1] 3.587319
  pmean("specdata", "nitrate")
  ## [1] 1.702932
  
  
  ```R
  
  > getwd()
  [1] "C:/Users/Vitalii/Documents"
  setwd("Lab 5")
  > setwd("Lab 5")
  > getwd()
  [1] "C:/Users/Vitalii/Documents/Lab 5"
  filelist <- list.files(path="specdata", pattern=".csv", full.names=TRUE)
  > length(filelist)
  [1] 332
  
  pmean <- function(directory, pollutant, id=1:332) {
    filelist <- list.files(path="specdata", pattern=".csv", full.names=TRUE)
    values <- numeric()
    for (i in id) {
      data <- read.csv(filelist[i])
      values <- c(values, data[[pollutant]])
    }
    mean(values, na.rm=TRUE)
  }
  
  > pmean("specdata", "sulfate", 1:10)
  [1] 4.064128
  > pmean("specdata", "sulfate", 55)
  [1] 3.587319
  > pmean("specdata", "nitrate")
  [1] 1.702932
  > pmean("specdata", "nitrate", 200:300)
  [1] 1.563453
  
  ```
  Написати функцію complete, яка виводить кількість повних спостережень
  (the number of completely observed cases) для кожного файлу. Функція
  приймає два аргументи: «Directory» та «id» та повертає data frame, в
  якому перший стовпчик – ім’я файлу, а другий – кількість повних
  спостережень. Приклад роботи функції:
    complete("specdata", 1)
  ## id nobs
  ## 1 1 117
  complete("specdata", c(2, 4, 8, 10, 12))
  ## id nobs
  ## 1 2 1041
  ## 2 4 474
  ## 3 8 192
  ## 4 10 148
  ## 5 12 96
  complete("specdata", 50:60)
  ## id nobs
  ## 1 50 459
  ## 2 51 193
  ## 3 52 812
  ## 4 53 342
  ## 5 54 219
  ## 6 55 372
  ## 7 56 642
  ## 8 57 452
  ## 9 58 391
  ## 10 59 445
  ## 11 60 448
  
  ```R
  
  complete <- function(directory, id=1:332 ) {
    filelist <- list.files(path=directory, pattern=".csv", full.names=TRUE)
    nobs <- numeric()
    for (i in id) {
      data <- read.csv(filelist[i])
      nobs <- c(nobs, sum(complete.cases(data)))
    }
    data.frame(id, nobs)
  }
  
  > complete("specdata", 1)
  id nobs
  1  1  117
  
  > complete("specdata", c(2, 4, 8, 10, 12))
  id nobs
  1  2 1041
  2  4  474
  3  8  192
  4 10  148
  5 12   96
  
  > complete("specdata", 50:60)
  id nobs
  1  50  459
  2  51  193
  3  52  812
  4  53  342
  5  54  219
  6  55  372
  7  56  642
  8  57  452
  9  58  391
  10 59  445
  11 60  448
  
  > complete("specdata", 250:255)
  id nobs
  1 250  180
  2 251   27
  3 252  509
  4 253  531
  5 254  437
  6 255  657
  
  ```
  
  3. Написати функцію corr, яка приймає два аргументи: directory (папка, де
  знаходяться файли спостережень) та threshold (порогове значення, за
  замовчуванням дорівнює 0) та обчислює кореляцію між сульфатами та
  нітратами для моніторів, кількість повних спостережень для яких більше
  порогового значення. Функція повинна повернути вектор значень
  кореляцій. Якщо ні один монітор не перевищує порогового значення,
  функція повинна повернути numeric вектор довжиною 0. Для обчислення
  кореляції між сульфатами та нітратами використовуйте вбудовану функцію 
  «cor» з параметрами за замовчуванням.
  Приклад роботи функції:
    cr <- corr("specdata", 150)
  head(cr); summary(cr)
  ## [1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -
  0.07588814
  ## Min. 1st Qu. Median Mean 3rd Qu. Max.
  ## -0.21060 -0.04999 0.09463 0.12530 0.26840 0.76310
  cr <- corr("specdata", 400)
  head(cr); summary(cr)
  ## [1] -0.01895754 -0.04389737 -0.06815956 -0.07588814 0.76312884 -
  0.15782860
  ## Min. 1st Qu. Median Mean 3rd Qu. Max.
  ## -0.17620 -0.03109 0.10020 0.13970 0.26850 0.76310
  cr <- corr("specdata", 5000)
  head(cr); summary(cr) ; length(cr)
  ## NULL
  ## Length Class Mode
  ## 0 NULL NULL
  ## [1] 0
  
  ```R
  
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
  }
  
  > cr <- corr("specdata", 150)
  > head(cr); summary(cr)
  [1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814
  Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
  -0.21057 -0.04999  0.09463  0.12525  0.26844  0.76313 
  
  > head(cr); summary(cr)
  [1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860
  Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
  -0.17623 -0.03109  0.10021  0.13969  0.26849  0.76313 
  
  > cr <- corr("specdata", 5000)
  > head(cr); summary(cr) ; length(cr)
  NULL
  Length  Class   Mode 
  0   NULL   NULL 
  [1] 0
  
  > cr <- corr("specdata", 1000)
  > head(cr); summary(cr)
  [1] -0.01895754  0.04191777  0.19014198
  Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
  -0.01896  0.01148  0.04192  0.07103  0.11603  0.19014 
  
  ```