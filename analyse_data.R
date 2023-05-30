library(sqldf)
source('mysql_client_r.R') #加载封装好的接口

data_frame <- get_table('ten_schools_exams') #获取整个表

#获取头尾各五行
print(head(data_frame, n=5))
print(tail(data_frame, n=5))

#画三科分数概率分布图
math_scores <- data_frame[['数学']]
plot(density(math_scores), ylim=c(0, 0.05), col='red', main='数学、语文、英语分数概率分布', xlab='分数', ylab='概率')

Chinese_scores <- data_frame[['语文']]
English_scores <- data_frame$英语
lines(density(Chinese_scores), col='green')
lines(density(English_scores), col='blue')

legend('topleft', inset=.05, title='科目', c('数学','语文','英语'), col=c('red','green','blue'), lty=c(1,1,1))

#杭州高级中学物理分数概览
detach("package:RMySQL", unload=T)
physics_hzgj <- sqldf('select 物理 from data_frame where 学校="杭州高级中学"')$物理
四一分位 <- c(unname(quantile(physics_hzgj, probs=0.25)))
四二分位 <- c(unname(quantile(physics_hzgj, probs=0.5)))
四三分位 <- c(unname(quantile(physics_hzgj, probs=0.75)))
平均分 <- c(mean(physics_hzgj))
标准差 <- c(sd(physics_hzgj))
学校 <- c('杭州高级中学')
physics_hzgj <- data.frame(学校,四一分位,四二分位,四三分位,平均分,标准差)
print(physics_hzgj)

#十校物理分数概览,建空白dataframe，遍历学校，然后rbind
get_school_subject_summary <- function (school, subject) {
  sql <- sprintf("select %s from ten_schools_exams where 学校= '%s'", subject, school)
  school_subject_data <- get_data(sql)[[subject]]
  四一分位 <- c(unname(quantile(school_subject_data, probs=0.25)))
  四二分位<- c(unname(quantile(school_subject_data, probs=0.5)))
  四三分位 <- c(unname(quantile(school_subject_data, probs=0.75)))
  平均分 <- c(mean(school_subject_data))
  标准差 <- c(sd(school_subject_data))
  学校 <- c(school)
  科目 <- c(subject)
  school_subject_summary <- data.frame(科目,学校,四一分位,四二分位,四三分位,平均分,标准差)
  return (school_subject_summary)
}

subjects <- c('数学','语文','英语','物理','化学','生物','总分')
schools <- unique(data_frame$学校)
for (subject in subjects) {
  subject_ten_schools <- data.frame(科目=character(0), 学校=character(0), 四一分位=integer(0),四二分=integer(0),四三分位=integer(0),平均分=numeric(0), 标准差=numeric(0))
  for (school in schools) {
    school_subject_summary <- get_school_subject_summary(school, subject)
    subject_ten_schools <- rbind(subject_ten_schools, school_subject_summary)
  }
  subject_ten_schools <- subject_ten_schools[order(-subject_ten_schools$平均分),]
  print(subject_ten_schools)
}