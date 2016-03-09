DROP DATABASE IF EXISTS django_db;
CREATE DATABASE django_db DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE USER 'django'@'localhost' IDENTIFIED BY 'imnotsecretdjangomysqlpassword';
GRANT ALL PRIVILEGES ON django_db.* TO 'django'@'localhost';
GRANT ALL PRIVILEGES ON test_django_db.* TO 'django'@'localhost';
FLUSH PRIVILEGES;