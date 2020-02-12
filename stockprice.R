#Part1
install.packages('quantmod')
install.packages('e1071')
library(quantmod)
library(e1071)
getSymbols('^TWII',src = 'yahoo', from="2019-01-01", to= "2019-09-30")
summary_TWII <- summary(TWII)
write.csv(summary_TWII,"TWII.csv")
Close_price <- TWII[,4]
write.csv(TWII,"TWII.csv")
#draw and save density graph
png("density.png",width = 480, height = 480)
plot(density(Close_price))
dev.off()
#draw and save Close Price graph
png("Close_Price.png",width = 480, height = 480)
plot(Close_price)
dev.off()

#draw and save Close Price Time-series graph
png("Close_Price_Time_Series.png",width = 1600, height = 1600)
chartSeries(TWII)
dev.off()

Daily_Return <- dailyReturn(Close_price)

#draw and save daily returns
png("DailyReturn.png",width = 480, height = 480)
plot(Daily_Return)
dev.off()

#summary statistics
summary(Close_price)
var(Close_price)
kurtosis(Close_price)
skewness(Close_price)
dailyReturn(Close_price)

#Part2
getSymbols('^TWII',src = 'yahoo', from="2019-01-01", to= "2019-03-31")
Q1L<-length(TWII[,4])
getSymbols('^TWII',src = 'yahoo', from="2019-04-01", to= "2019-06-30")
Q2L<-length(TWII[,4])
getSymbols('^TWII',src = 'yahoo', from="2019-07-01", to= "2019-09-30")
Q3L<-length(TWII[,4])

X1<-c()
X1<-rep(1,times=Q1L)
X1<-c(X1,rep(0,times=Q2L+Q3L))

X2<-c()
X2<-rep(0,times=Q1L)
X2<-c(X2,rep(1,times=Q2L))
X2<-c(X2,rep(0,times=Q3L))

X3<-c()
X3<-rep(0,times=Q1L+Q2L)
X3<-c(X3,rep(1,times=Q3L))

Two_Dummy_Variables <- lm(Daily_Return~X1+X2)
summary(Two_Dummy_Variables)

Three_Dummy_Variables <- lm(Daily_Return~X1+X2+X3)
summary(Three_Dummy_Variables)