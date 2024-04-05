echo -e "\e[34m enabling nodejs version 18 \e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[34m installing nodejs \e[0m"
dnf install nodejs -y

echo -e "\e[34m adding user \e[0m"
useradd roboshop

echo -e "\e[34m create app directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[34m Download the application code to created app directory \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app

echo -e "\e[34m download the dependencies \e[0m"
npm install

cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[33m starting catalogue \e[0m"
systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue

echo -e "\e[33m Setting up SystemD Catalogue Service \e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[34m install Mongodb server \e[0m"

dnf install mongodb-org-shell -y

echo -e "\e[33m Loading List of products we want to sell \e[0m"
mongo --host mongodb-dev.devopsb73.tech </app/schema/catalogue.js
