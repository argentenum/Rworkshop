#vectors
march <- c(1,2,3,4,5,6,7,8)
str(march)
print(march)
#string vectors
week <- c("mon","tue","wed","thu","fri","sat","sun")
str(week)
week
#vector values can either numeric or string
mismatch <- c(1,"one")
print(mismatch)
#sort function
sort(week)
#sort in descending order
sort(week, decreasing = TRUE)
#various methods of creating vectors
x <- c(1,3,5)
x <- c(1:5)
#adding values to a vector
x <- c(x,6,7)
#append value in between vector values
x <- append(x,8,2)
x <- append(x,c(100,200),5)
#appending character value to numerical vector
x <- append(x, "bad")
#creating vector through sequence
y <- seq(1,100, by = 5)
y <- seq(1,100, by = (3*3))
#creating vector by division
f <- seq(1,100, length= 25)
f <- seq(1,50, length=6)
#fetching values by index
z <- c(1,3,5)
y[z]
y[-1]
y[-z]
#vector arithmetic
u <- c(2,4,6)
z+u 
u-z
u*z
u/z
t <- c(1,2,3,4)
t+u
u-t
u*t
t*u
u/t
#which function - logical
#logical symbols == > < >= <= !=
y>50
which(y>50)
y[which(y>50)]
which(week == "thu")
#divisibility
y%%2
#finding even values
which(y%%2==0)
y[which(y%%2==0)]
#any and all
any(y>50)
all(y>50)
#if else
ifelse(y >50, "yes","no")

