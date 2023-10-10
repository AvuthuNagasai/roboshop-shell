dnf install nginx -y

echo -e "\e[31mremoving old app content\e[om"
rm -rf /usr/share/nginx/html/*

echo -e "\e[32mdownloading frontend component\e[om"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[33mextract frontend content\e[om"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
## we need to copy config file

echo -e "\e[33mstarting nginx content\e[om"
systemctl enable nginx
systemctl start nginx
