library(MASS)

prepare_scores <- function(row_number, means_vector, sigma_matrix){
  scores <- mvrnorm(row_number,means_vector,sigma_matrix)
  scores <- round(scores, digits = 0)
  scores_dataframe <- as.data.frame(scores)
  names(scores_dataframe) <- c('数学','语文','英语','物理','化学','生物')
  scores_dataframe$数学[scores_dataframe$数学 > 150] <- 150
  scores_dataframe$语文[scores_dataframe$语文 > 150] <- 150
  scores_dataframe$英语[scores_dataframe$英语 > 150] <- 150
  scores_dataframe$物理[scores_dataframe$物理 > 120] <- 120
  scores_dataframe$化学[scores_dataframe$化学 > 100] <- 100
  scores_dataframe$生物[scores_dataframe$生物 > 80] <- 80
  scores_dataframe$总分 <- scores_dataframe$数学+scores_dataframe$语文+scores_dataframe$英语+scores_dataframe$物理+scores_dataframe$化学+scores_dataframe$生物
  scores_dataframe <- scores_dataframe[order(-scores_dataframe$总分),]
  print('head:')
  print(head(scores_dataframe, n=50))
  print('tail:')
  print(tail(scores_dataframe, n=50))
  write.csv(mydata, file='scores.csv')
}

row <- 5000
mean <- c(115,110,120,95,78,62)
sigma <- matrix(c(100,10,12,36,36,32,10,75,36,10,10,10,12,36,84,12,12,12,36,10,12,70,36,32,36,10,12,36,54,32,32,10,12,32,32,46),6,6)

prepare_scores(row, mean, sigma)