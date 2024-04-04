echo -e "\e[32m copying mongodb repo file \e[0m"

cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33m install Mongodb server \e[0m"
dnf install mongodb-org -y &>>/tmp/roboshop.log

## Modify the config file
echo -e "\e[34m updating mongodb server listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[35m start mongoDB service \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl start mongod &>>/tmp/roboshop.log