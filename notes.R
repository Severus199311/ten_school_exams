#1.确定平均分A（总分600，数学118，语文112，英文125，物理96，化学84，生物65）和标准差，取100个正态分布值
#2.50个人一组，一共100组，分别以上述100个正态分布值为平均分，确定标准差，越靠近平均分A，标准差越小

#3.各科两两相关性检验
#4.各校各科成绩对比，曲线图

#78,10,12,36,36,32,10,68,36,10,10,10,12,36,68,12,12,12,36,10,12,64,36,32,36,10,12,36,48,32,32,10,12,32,32,48

library(MASS)
options(digits = 2)
mean <- c(115,110,120,95,78,62)
sigma <- matrix(c(100,10,12,36,36,32,10,75,36,10,10,10,12,36,84,12,12,12,36,10,12,70,36,32,36,10,12,36,54,32,32,10,12,32,32,46),6,6)
mydata <- mvrnorm(5000,mean,sigma)
mydata <- round(mydata, digits = 0)
mydata <- as.data.frame(mydata)
names(mydata) <- c('数学','语文','英语','物理','化学','生物')
mydata$数学[mydata$数学 > 150] <- 150
mydata$语文[mydata$语文 > 150] <- 150
mydata$英语[mydata$英语 > 150] <- 150
mydata$物理[mydata$物理 > 120] <- 120
mydata$化学[mydata$化学 > 100] <- 100
mydata$生物[mydata$生物 > 80] <- 80
#scores <- sort(mydata[['生物']], decreasing = FALSE)
#probibility <- dnorm(scores, 62, sqrt(46))
#plot(scores, probibility, type='l', xlab='scores', ylab='density')
#print(scores[scores < 54])
mydata$总分 <- mydata$数学+mydata$语文+mydata$英语+mydata$物理+mydata$化学+mydata$生物
mydata <- mydata[order(-mydata$总分),]
print(head(mydata, n=100))
write.csv(mydata, file='data.csv')

#数据还要修正，超过满分的纠正为满分，部分科目不适合满分
#使用R的xlsx包，需要安装jdk
#readxl包似乎可以：data <- read_xls('scores.xls') print(data, n=100)