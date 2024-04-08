dnf module disable nodejs -y &>>/tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

dnf install nodejs -y &>>/tmp/roboshop.log

useradd roboshop

mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

cd /app
npm install &>>/tmp/roboshop.log

cp /root/roboshop-shell/mongodb.repo /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log

cp /etc/yum.repos.d/mongo.repo /etc/systemd/system/catalogue.service

dnf install mongodb-org-shell -y &>>/tmp/roboshop.log

mongo --host mongodb-dev.devopsb73.tech </app/schema/catalogue.js &>>/tmp/roboshop.log