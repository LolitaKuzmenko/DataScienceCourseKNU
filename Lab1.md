Ëàáîðàòîðíà ðîáîòà ¹ 1
Â ëàáîðàòîðí³é ðîáîò³ íåîáõ³äíî âèêîíàòè íàñòóïí³ ä³¿:
1. Ñòâîðèòè çì³íí³ áàçîâèõ (atomic) òèï³â. Áàçîâ³ òèïè: character, numeric,
integer, complex, logical.

```R

>ch<-"penguin" ##character
> ch
[1] "penguin"

>num<-3.14 ##numeric
> num
[1] 3.14

>int<-6 ##integer
> int
[1] 6

>compl<-8+2i ##complex
> compl
[1] 8+2i

>logi<-T ##logical
> logi
[1] TRUE

```

2. Ñòâîðèòè âåêòîðè, ÿê³: ì³ñòèòü ïîñë³äîâí³ñòü ç 5 äî 75; ì³ñòèòü ÷èñëà 3.14,
2.71, 0, 13; 100 çíà÷åíü TRUE.

```R

> vint<-(5:75) ##vector integer
> vint
[1]  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
[28] 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58
[55] 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75

> vnum<-c(3.14, 2.71, 0, 13) ##vector numeric
> vnum
[1]  3.14  2.71  0.00 13.00

>vlogi<-rep(T,100) ##vector logical
> vlogi
 [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [16] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [31] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [46] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [61] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [76] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [91] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE

```

3. Ñòâîðèòè íàñòóïíó ìàòðèöþ çà äîïîìîãîþ matrix, òà çà äîïîìîãîþ cbind
àáî rbind
0.5 1.3 3.5
3.9 131 2.8
0 2.2 4.6
2 7 5.1

```R

> mma<-matrix(c(0.5, 3.9, 0, 2, 1.3, 131, 2.2, 7, 3.5, 2.8, 4.6, 5.1), nrow=4, ncol=3)
> mma
     [,1]  [,2] [,3]
[1,]  0.5   1.3  3.5
[2,]  3.9 131.0  2.8
[3,]  0.0   2.2  4.6
[4,]  2.0   7.0  5.1

> c1<-c(0.5, 3.9, 0, 2)
> c2<-c(1.3, 131, 2.2, 7)
> c3<-c(3.5, 2.8, 4.6, 5.1)
> cbind(c1, c2, c3)
      c1    c2  c3
[1,] 0.5   1.3 3.5
[2,] 3.9 131.0 2.8
[3,] 0.0   2.2 4.6
[4,] 2.0   7.0 5.1

```

4. Ñòâîðèòè äîâ³ëüíèé ñïèñîê (list), â ÿêèé âêëþ÷èòè âñ³ áàçîâ³ òèïè.

```R

> l<-list(15, 0.58, "bear", 1+4i, F)
> l
[[1]]
[1] 15

[[2]]
[1] 0.58

[[3]]
[1] "bear"

[[4]]
[1] 1+4i

[[5]]
[1] FALSE

```

5. Ñòâîðèòè ôàêòîð ç òðüîìà ð³âíÿìè «baby», «child», «adult».

```R

> fact<-factor(c("baby", "child", "adult"), levels=c("baby", "child", "adult"))
> fact
[1] baby  child adult
Levels: baby child adult

```

6. Çíàéòè ³íäåêñ ïåðøîãî çíà÷åííÿ NA â âåêòîð³ 1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11. Çíàéòè ê³ëüê³ñòü çíà÷åíü NA.

```R

> cind<-c(1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11) 
> cind
 [1]  1  2  3  4 NA  6  7 NA  9 NA 11
> match(NA, cind) ##index of the first NA
[1] 5
> sum(is.na(cind)) ##number of NA values
[1] 3

```

7. Ñòâîðèòè äîâ³ëüíèé data frame òà âèâåñòè â êîíñîëü.

```R

> df<-data.frame(region=c("Kyiv", "Lviv", "Kharkiv", "Odesa"), year=c(482, 1256, 1654, 1794))
> df
   region year
1    Kyiv  482
2    Lviv 1256
3 Kharkiv 1654
4   Odesa 1794

```

8. Çì³íèòè ³ìåíà ñòîâïö³â öüîãî data frame.

```R

> names(df)<-c("city", "foundation")
> names(df)
[1] "city"       "foundation"
> df
     city foundation
1    Kyiv        482
2    Lviv       1256
3 Kharkiv       1654
4   Odesa       1794

```
