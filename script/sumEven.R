disco <- c(1,2,3,4)
sumEven <- 0
for (n in 1:length(disco))
{
  ifelse(disco[n] %% 2 == 0,jog <- disco[n], jog <- 0)
  sumEven <- sumEven + jog
  print(n)
  print(sumEven)
}
