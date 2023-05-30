library(sqldf)
source('mysql_client_r.R') #加载封装好的接口

data_frame <- get_table('ten_schools_exams') #获取整个表

#140的分数在三科中的累积概率密度
print(pnorm(140, mean=mean(data_frame$数学), sd=sd(data_frame$数学)))
print(pnorm(140, mean=mean(data_frame$语文), sd=sd(data_frame$语文)))
print(pnorm(140, mean=mean(data_frame$英语), sd=sd(data_frame$英语)))

#化学成绩pnorm
data_frame[['化学_pnorm']] <- pnorm(data_frame$化学, mean=mean(data_frame$化学), sd=sd(data_frame$化学))
print(head(data_frame, n=100))

#所有科目和总分pnorm
for (subject in c('数学','语文','英语','物理','化学','生物')) {
  data_frame[[paste(subject,'_pnorm', sep='')]] <- pnorm(data_frame[[subject]], mean=mean(data_frame[[subject]]), sd=sd(data_frame[[subject]]))
}

data_frame$总分_pnorm <- data_frame$数学_pnorm + data_frame$语文_pnorm + data_frame$英语_pnorm + data_frame$物理_pnorm + data_frame$化学_pnorm + data_frame$生物_pnorm

data_frame_a <- data_frame[order(-data_frame$总分_pnorm),]
index <- order(-data_frame_a$总分_pnorm)
data_frame_a$序号_pnorm <- index

data_frame$序号_difference <- data_frame$序号 - data_frame$序号_pnorm
data_frame <- data_frame[order(-data_frame$序号_difference),]

data_frame_b <- data_frame_a[c('序号','序号_pnorm','姓名','性别','学校','数学','语文','英语','物理','化学','生物','总分','总分_pnorm')]
print(head(data_frame_b, n=10))