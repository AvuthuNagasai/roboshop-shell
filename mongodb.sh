echo -e "\e[32mcopying mongodb repo file \e[0m"

cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33m install Mongodb server \e[0m"
dnf install mongodb-org -y &>>/tmp/roboshop.log

## Modify the config file

echo -e "\e[35m start MongoDB service \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl start mongod &>>/tmp/roboshop.log