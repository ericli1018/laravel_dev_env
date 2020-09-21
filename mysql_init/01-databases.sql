# create databases
CREATE DATABASE IF NOT EXISTS `cloud_api_service`;
CREATE DATABASE IF NOT EXISTS `bnc_factory`;

# create root user and grant rights
CREATE USER 'root'@'localhost' IDENTIFIED BY 'local';
GRANT ALL ON *.* TO 'root'@'%';