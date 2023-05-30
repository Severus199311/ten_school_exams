import pymysql, xlrd


class MySQLClient():

	def __init__(self):

		self.db = pymysql.connect(host = 'localhost', port = 3306, user = 'root', password = '199311', db = 'new_schema', charset = 'utf8mb4')
		self.cursor = self.db.cursor()

	def execute_sql(self, sql, values):

		self.cursor.execute(sql, values)
		self.db.commit()

	def read_excel(self, workbook_title, sheet_name):

		workbook_read = xlrd.open_workbook(workbook_title)
		sheet_data = workbook_read.sheet_by_name(sheet_name)
		return sheet_data

if __name__ == '__main__':

	my_sql_client = MySQLClient()
	workbook_title = 'scores.xls'
	sheet_name = 'Sheet1'
	sheet_data = my_sql_client.read_excel(workbook_title, sheet_name)
	keys = ','.join(sheet_data.row_values(0))
	
	for row in range(1, sheet_data.nrows):
		values_list = sheet_data.row_values(row)
		values_list = [str(value) for value in values_list]
		values_format = ','.join(['%s'] * len(values_list))

		sql = 'insert into %s (%s) values (%s)' %('ten_schools_exams', keys, values_format)
		my_sql_client.execute_sql(sql, tuple(values_list))