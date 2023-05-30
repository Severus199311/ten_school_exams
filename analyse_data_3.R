source('mysql_client_r.R') #加载封装好的接口

data_frame <- get_table('ten_schools_exams') #获取整个表
data_frame <- data_frame[order(data_frame$数学),]

plot(data_frame$数学, data_frame$物理, type='p', xlab='Math', ylab='Physics', pch=16, cex=0.5)
plot(data_frame$数学, data_frame$语文, type='p', xlab='Math', ylab='Chinese', pch=16, cex=0.5)

print(cov(data_frame$数学, data_frame$物理))
print(cov(data_frame$数学, data_frame$语文))

print(cor(data_frame$数学, data_frame$物理))
print(cor(data_frame$数学, data_frame$语文))