echo -e "\e[34m enabling nodejs version 18 \e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log
echo -e "\e[34m installing nodejs \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[34m adding user roboshop \e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[34m create app directory \e[0m"
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[34m Download the application code to created app directory \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
echo -e "\e[34m download the dependencies \e[0m"
cd /app
npm install &>>/tmp/roboshop.log
echo -e "\e[34m Setting up SystemD Catalogue Service \e[0m"
cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
echo -e "\e[34m starting catalogue \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log
echo -e "\e[34m copy mongodb repo file \e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo -e "\e[34m install Mongodb server \e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log &>>/tmp/roboshop.log
echo -e "\e[34m Loading List of products we want to sell \e[0m"
mongo --host mongodb-dev.devopsb73.tech </app/schema/catalogue.js &>>/tmp/roboshop.log