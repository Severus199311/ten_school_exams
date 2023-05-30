library(RMySQL)

#连接数据库
db_connect <- function() {
  db <- dbConnect(RMySQL::MySQL(), dbname='new_schema', username='root', password='199311', host='localhost')
  return(db)
}

#根据表名获取表全量数据
get_table <- function(table_name){
  db <- db_connect()
  data <- dbReadTable(db, table_name)
  dbDisconnect(db)
  return(data)
}

#根据表名和字段名获取某表某字段数据
get_column <- function(table_name, column_name) {
  db <- db_connect()
  sql <- sprintf('SELECT %s FROM %s', column_name, table_name)
  data <- dbSendQuery(db, sql)
  data <- dbFetch(data, n=-1)
  dbDisconnect(db)
  return(data)
}

#根据SQL语句获取数据
get_data <- function(sql) {
  db <- db_connect()
  data <-dbSendQuery(db, sql)
  data <- dbFetch(data, n=-1)
  dbDisconnect(db)
  return(data)
}

#根据SQL语句修改表
alter_table <- function(sql) {
  db <- db_connect()
  dbSendQuery(db, sql)
  dbDisconnect(db)
}

