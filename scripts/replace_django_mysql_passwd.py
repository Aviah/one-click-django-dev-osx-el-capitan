import os
from site_repo.settings import DATABASES
passwd = DATABASES['default']['PASSWORD']
sql_file = "%s/%s"%(os.path.dirname(os.path.abspath(__file__)),"db.sql")

prev = open(sql_file).read()
new_passwd = prev.replace("imnotsecretdjangomysqlpassword",passwd)
db_file = open(sql_file,'w')
db_file.write(new_passwd)
db_file.close()
