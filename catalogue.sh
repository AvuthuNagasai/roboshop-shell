echo -e "\e[34m enabling nodejs version 18 \e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y


echo -e "\e[34m installing nodejs \e[0m"
dnf install nodejs -y
echo -e "\e[34m adding user \e[0m"
useradd roboshop

rm -rf /app
mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

cp  /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue

cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

dnf install mongodb-org-shell -y

mongo --host mongodb-dev.devopsb73.tech </app/schema/catalogue.js