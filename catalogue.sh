echo -e "\e[34m enabling nodejs version 18 \e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "\e[34m installing nodejs \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[34m adding user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34m create app directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[34m Download the application code to created app directory \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

cd /app

echo -e "\e[34m download the dependencies \e[0m"
npm install &>>/tmp/roboshop.log

cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33m starting catalogue \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log

echo -e "\e[33m Setting up SystemD Catalogue Service \e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[34m install Mongodb server \e[0m"

dnf install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33m Loading List of products we want to sell with mongodb \e[0m"

mongo --host 172.31.90.239 </app/schema/catalogue.js

systemctl enable catalogue
systemctl start catalogue