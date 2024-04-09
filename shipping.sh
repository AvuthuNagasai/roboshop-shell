echo -e "\e[33m installing maven \e[0m"

dnf install maven -y

echo -e "\e[33m adding user \e[0m"
useradd roboshop
echo -e "\e[34m create app directory \e[0m"
mkdir /app

echo -e "\e[33m Download the application code to created app directory \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip

echo -e "\e[33m download the dependencies & build the application \e[0m"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[33m Setting up SystemD shipping Service \e[0m"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[33m starting shipping \e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping

echo -e "\e[33m installing mysql \e[0m"
dnf install mysql -y

echo -e "\e[33m Loading Schema \e[0m"
mysql -h mysql-dev.devopsb73.tech -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[33m starting shipping \e[0m"
systemctl restart shipping

