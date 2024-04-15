echo -e "\e[33m installing python \e[0m"
dnf install python36 gcc python3-devel -y

echo -e "\e[34m adding user \e[0m"
useradd roboshop

mkdir /app

echo -e "\e[34m Download the application code to created app directory \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip

echo -e "\e[34m Lets download the dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt

echo -e "\e[34m Setup SystemD Payment Service \e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[34m Start payment service \e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment