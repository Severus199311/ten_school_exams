library(sqldf)
source('mysql_client_r.R') #加载封装好的接口

data_frame <- get_table('ten_schools_exams') #获取整个表

for (subject in c('数学','语文','英语','物理','化学','生物')) {
  subject_pnorm <- paste(subject,'_pnorm', sep='')
  data_frame[[subject_pnorm]] <- pnorm(data_frame[[subject]], mean=mean(data_frame[[subject]]), sd=sd(data_frame[[subject]]))
}

data_frame$总分_pnorm <- data_frame$数学_pnorm + data_frame$语文_pnorm + data_frame$英语_pnorm + data_frame$物理_pnorm + data_frame$化学_pnorm + data_frame$生物_pnorm
data_frame <- data_frame[order(-data_frame$总分_pnorm),]