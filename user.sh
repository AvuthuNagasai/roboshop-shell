echo -e "\e[34m enable nodejs version 18 \e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log
echo -e "\e[34m install node js \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[34m adding user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34m setting up root directory \e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34m Download the application code to created app directory \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log

cd /app
unzip /tmp/user.zip &>>/tmp/roboshop.log


echo -e "\e[34m download the dependencies \e[0m"cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[33m Setting up SystemD user Service \e[0m"
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log


echo -e "\e[33m starting user \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl start user &>>/tmp/roboshop.log