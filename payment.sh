echo -e "\e[33m installing python \e[0m"
dnf install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[34m adding user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34m Download the application code to created app directory \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/payment.zip &>>/tmp/roboshop.log

echo -e "\e[34m Lets download the dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[34m Setup SystemD Payment Service \e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[34m Start payment service \e[0m"
systemctl daemon-reload
systemctl enable payment &>>/tmp/roboshop.log
systemctl start payment &>>/tmp/roboshop.log