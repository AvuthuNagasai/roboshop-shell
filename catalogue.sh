echo -e "\e[34m enabling nodejs version 18 \e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[34m installing nodejs \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[34m adding user roboshop \e[0m"
useradd roboshop
echo -e "\e[34m setting app directory \e[0m"
mkdir /app
echo -e "\e[34m Download the application code to created app directory \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
echo -e "\e[34m download the dependencies \e[0m"
cd /app
npm install
echo -e "\e[34m Setting up SystemD Catalogue Service \e[0m"
cp Catalogue Service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
echo -e "\e[34m reload the service \e[0m"
systemctl daemon-reload
echo -e "\e[34m starting catalogue \e[0m"
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[34m copy mongodb repo file \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo -e "\e[34m install Mongodb server \e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[34m Loading List of products we want to sell \e[0m"
mongo --host 	mongodb-dev.devopsb73.tech </app/schema/catalogue.js &>>/tmp/roboshop.log

