Лабораторна робота № 7.
Для виконання роботи можна скористатись бібліотекою stringr від tidyverse
https://stringr.tidyverse.org/index.html
Частина 1.
Завантажте файл “olympics.csv” за посиланням
https://www.dropbox.com/s/9oayr45v7nj30nv/olympics.csv?dl=0
Цей файл базується на статті в Wikipedia All Time Olympic Games Medals Спочатку
необхідно провести базову обробку файлу.
Напишіть функцію prepare_set <- function(file_name) {} яка в якості аргументу
приймає ім’я файлу і повертає дата фрейм. Збережіть цей дата фрейм в змінну
olympics
olympics <- prepare_set(“olympics.csv”)
Функція prepare_set повинна виконувати наступні дії:
1. Зчитати файл
read.csv("olympics.csv", skip = 1, header = TRUE, encoding="UTF-8",
stringsAsFactors = FALSE)
2. Першому стовпцю дати назву “Country”
3. Автоматично в циклі згенерувати назви останніх стовпців за наступними
правилами:
3.1. Видалити з назви “X.U.2116..”, тобто “X.U.2116..Summer” буде
“Summer”
3.2. “X01..” замінити на “Gold”, тобто “ X01...1” буде “Gold.1”
3.3. “X02..” та “X03..” замінити на “Silver” та “Bronze” відповідно
В результаті повинні бути наступні назви стовпців: "Country", "Summer",
"Gold", "Silver", "Bronze", "Total", "Winter", "Gold.1", "Silver.1", "Bronze.1",
"Total.1", "Games", "Gold.2", "Silver.2", "Bronze.2", "Combined.total"
4. Необхідно привести назви країн до виду "Afghanistan", "Algeria" і т.п. Для
цього можна використати функцію split. В назві країн не повинно бути
пробілів на початку та в кінці.
5. Додайте до дата фрейму новий стовпець “ID”, в який запишіть трибуквений
код країна. Наприклад, "AFG", "ALG" і т.п.
6. Видаліть з дата фрейму останню строку “Totals”
Для кожного наступного питання напишіть функцію, яка повертає вказаний 
результат. Назви функції “answer_one” для питання 1, “answer_two” для
питання 2 і т.д.

Питання 1
Котра країна виграла найбільшу кількість золотих нагород на літніх іграх?
Функція повинна повернути одне текстове значення.

Питання 2
Яка країна має найбільшу різницю між кількістю нагород на літніх та зимових
іграх?
Функція повинна повернути одне текстове значення.

Питання 3
В якій крайні найбільша різниця між літніми та зимовими золотими нагородами
відносно до загальної кількості нагород (Summer Gold - Winter Gold) / Total Gold.
Врахувати тільки країни які мають як мінімум по одній нагороді в літніх та
зимових іграх.
Функція повинна повернути одне текстове значення.

Питання 4
Необхідно знайти кількість балів по кожній крайні. Бали рахуються наступним
чином: Золота нагорода Gold.2 це три бали, срібна Silver.2 - 2 бали та бронзова
Bronze.2 – 1 бал.
Функція повинна повертати дата фрейм довжиною 146, який складається з двох
колонок: "Country", "Points".


```R

> install.packages("stringr")
> library(stringr)
> setwd("C:/Users/Vitalii/Downloads")
> getwd()
[1] "C:/Users/Vitalii/Downloads"

prepare_set <- function(file_name) {
  df <- read.csv(file_name, skip = 1, header = TRUE, encoding = "UTF-8", stringsAsFactors = FALSE)
  names(df)[1] <- "Country"
  t<-length(colnames(df[1]))
  for (i in 1:t) {
    colnames(df)=sub("X..", "", colnames(df), fixed=TRUE)
    colnames(df)=sub("X01..", "Gold", colnames(df))
    colnames(df)=sub("X02..", "Silver", colnames(df))
    colnames(df)=sub("X03..", "Bronze", colnames(df))
  }
  spl<-strsplit( df$Country, "[(]" )
  df$Country<-sapply(spl, "[", 1) 
  df$Country<-str_trim(df$Country)
  df$ID<-str_sub(sapply(spl, "[", 2), 1, 3)
  df<-df[-which(df$Country=="Totals"), ]
  df
}

olympics <- prepare_set("olympics.csv")


answer_one<-function() {
  olympics[which.max(olympics$Gold), "Country"]
}

> answer_one()
[1] "United States"


answer_two<-function() {
  olympics[which.max(olympics$Total-olympics$Total.1), "Country"]
}

> answer_two()
[1] "United States"


answer_three<-function() {
  my_subset<-subset(olympics, Gold>=1 & Gold.1>=1)
  my_subset[which.max((my_subset$Gold-my_subset$Gold.1)/my_subset$Gold.2), "Country"]
}

> answer_three()
[1] "Bulgaria"


answer_four<-function() {
  olympics$Points<-(olympics$Gold.2*3 + olympics$Silver.2*2 + olympics$Bronze.2*1)
  olympics[, c("Country", "Points")]
}

> answer_four()
                             Country Points
1                        Afghanistan      2
2                            Algeria     27
3                          Argentina    130
4                            Armenia     16
5                        Australasia     22
6                          Australia    923
7                            Austria    569
8                         Azerbaijan     43
9                            Bahamas     24
10                           Bahrain      1
11                          Barbados      1
12                           Belarus    154
13                           Belgium    276
14                           Bermuda      1
15                           Bohemia      5
16                          Botswana      2
17                            Brazil    184
18               British West Indies      2
19                          Bulgaria    411
20                           Burundi      3
21                          Cameroon     12
22                            Canada    846
23                             Chile     24
24                             China   1120
25                          Colombia     29
26                        Costa Rica      7
27                       Ivory Coast      2
28                           Croatia     67
29                              Cuba    420
30                            Cyprus      2
31                    Czech Republic    134
32                    Czechoslovakia    327
33                           Denmark    335
34                          Djibouti      1
35                Dominican Republic     14
36                           Ecuador      5
37                             Egypt     49
38                           Eritrea      1
39                           Estonia     77
40                          Ethiopia     94
41                           Finland    895
42                            France   1500
43                             Gabon      2
44                           Georgia     42
45                           Germany   1546
46            United Team of Germany    269
47                      East Germany   1068
48                      West Germany    459
49                             Ghana      5
50                     Great Britain   1574
51                            Greece    213
52                           Grenada      3
53                         Guatemala      2
54                            Guyana      1
55                             Haiti      3
56                         Hong Kong      6
57                           Hungary    962
58                           Iceland      6
59                             India     50
60                         Indonesia     49
61                              Iran    110
62                              Iraq      1
63                           Ireland     55
64                            Israel     10
65                             Italy   1333
66                           Jamaica    131
67                             Japan    866
68                        Kazakhstan    113
69                             Kenya    168
70                       North Korea     90
71                       South Korea    609
72                            Kuwait      2
73                        Kyrgyzstan      4
74                            Latvia     47
75                           Lebanon      6
76                     Liechtenstein     15
77                         Lithuania     38
78                        Luxembourg      9
79                         Macedonia      1
80                          Malaysia      9
81                         Mauritius      1
82                            Mexico    109
83                           Moldova      9
84                          Mongolia     37
85                        Montenegro      2
86                           Morocco     39
87                        Mozambique      4
88                           Namibia      8
89                       Netherlands    727
90              Netherlands Antilles      2
91                       New Zealand    203
92                             Niger      1
93                           Nigeria     37
94                            Norway    985
95                          Pakistan     19
96                            Panama      5
97                          Paraguay      2
98                              Peru      9
99                       Philippines     11
100                           Poland    520
101                         Portugal     39
102                      Puerto Rico     10
103                            Qatar      4
104                          Romania    572
105                           Russia   1042
106                   Russian Empire     14
107                     Soviet Union   2526
108                     Unified Team    287
109                     Saudi Arabia      4
110                          Senegal      2
111                           Serbia     11
112            Serbia and Montenegro     17
113                        Singapore      6
114                         Slovakia     58
115                         Slovenia     56
116                     South Africa    148
117                            Spain    268
118                        Sri Lanka      4
119                            Sudan      2
120                         Suriname      4
121                           Sweden   1217
122                      Switzerland    630
123                            Syria      6
124                   Chinese Taipei     32
125                       Tajikistan      4
126                         Tanzania      4
127                         Thailand     44
128                             Togo      1
129                            Tonga      2
130              Trinidad and Tobago     27
131                          Tunisia     19
132                           Turkey    191
133                           Uganda     14
134                          Ukraine    220
135             United Arab Emirates      3
136                    United States   5684
137                          Uruguay     16
138                       Uzbekistan     38
139                        Venezuela     18
140                          Vietnam      4
141                   Virgin Islands      2
142                       Yugoslavia    171
143 Independent Olympic Participants      4
144                           Zambia      3
145                         Zimbabwe     18
146                       Mixed team     38

```

Частина 2.
Для наступних питань використаємо дані перепису населення від United States
Census Bureau. Цей набір даних містить дані по населенню для округів і штатів в
США з 2010 по 2015 рокі. В цьому документі є опис назв змінних.
Завантажити файл можна за посиланням
https://www.dropbox.com/s/c1b2vqg8i3m1n93/census.csv?dl=0
Файл необхідно завантажити в змінну census_df
#Зчитуємо файл
census_df <- read.csv("census.csv", stringsAsFactors = FALSE)
Питання 5
В якому штаті (state) більше всього округів (county)?
Функція повинна повернути одне текстове значення
Питання 6
Якщо розглядати три найбільш населених округа (county) з кожного штату, які три
найбільш населені штати (в порядку з більш до менш населеного)?
Використовуйте CENSUS2010POP.
Функція повинна повернути вектор з трьох текстових значень.
Питання 7
Який округ (county) має найбільшу абсолютну зміну в населенні протягом
періоду 2010-2015?
(Підказка: значення населення зберігається в колонках з POPESTIMATE2010 до
POPESTIMATE2015. Необхідно розглядати всі шість колонок).
Якщо населення округу за 5річний період 100, 120, 80, 105, 100, 130, то найбільша
різниця за період буде |130-80|=50.
Функція повинна повернути одне текстове значення.
Питання 8
В census_df США поділені на 4 регіони (колонка "REGION"). Напишіть функцію,
яка знаходить округи (county), що належать регіонам 1 або 2, назва яких
починається з "Washington" та POPESTIMATE2015 більше ніж POPESTIMATE2014.
Функція повинна повернути 5х2 дата фрейм з колонками "STNAME", "CTYNAME".


```R

> census_df <- read.csv("census.csv", stringsAsFactors = FALSE)

answer_five<-function() {
  census_df_gr<-split(census_df[ , "CTYNAME"], census_df[ , "STNAME"])
  ncounty<-sapply(census_df_gr, length)
  which.max(ncounty)
}

> answer_five()
Texas 
   44 


answer_six<-function() {
  df_order<-census_df[order(census_df$STNAME, -census_df$CENSUS2010POP), ]
  df_split<-split(df_order, df_order$STNAME)
  df_split<-lapply(df_split, function (x) sum (x[2:4, "CENSUS2010POP"]))
  df_split<-df_split[order(unlist(df_split), decreasing = TRUE, na.last = TRUE)]
  names(df_split) [1:3]
}

> answer_six()
[1] "California" "Texas"      "Illinois"

answer_seven<-function() {
  df_pop2<-census_df[, 10:15]
  pop_max<-apply(df_pop2, 1, max)
  pop_min<-apply(df_pop2, 1, min)
  pop_change<-(pop_max-pop_min)
  df_pop2<-cbind(CTYNAME = census_df$CTYNAME, pop_change)
  df_pop2[which.max(pop_change)]
  }

> answer_seven()
[1] "Texas"


answer_eight <- function() {
df_pop3<-subset(census_df, (REGION==1 | REGION==2))
df_pop4<-df_pop3[grep("Washington", df_pop3$CTYNAME),]
df_pop5<-subset(df_pop4, POPESTIMATE2015>POPESTIMATE2014)
df_pop5[ , c("STNAME", "CTYNAME")]
}

> answer_eight()
           STNAME           CTYNAME
897          Iowa Washington County
1420    Minnesota Washington County
2346 Pennsylvania Washington County
2356 Rhode Island Washington County
3164    Wisconsin Washington County

```
