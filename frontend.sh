dnf install nginx -y &>>/tmp/roboshop.log

echo -e "\e[31mremoving old app content\e[om"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[32mdownloading frontend component\e[om"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[33mextract frontend content\e[om"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
## we need to copy config file

echo -e "\e[34mstarting nginx content\e[om"
systemctl enable nginx
systemctl start nginx
