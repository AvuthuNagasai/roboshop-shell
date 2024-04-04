echo -e "\e[31m Installing NGINX \e[0m"
dnf install nginx -y

echo -e "\e[31m Start & Enable Nginx service \e[0m"
systemctl enable nginx
systemctl start nginx

echo -e "\e[31m removing old app content \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[32m download frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[31m extracting frontend content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

rm -rf /etc/nginx/default.d/roboshop.conf

echo -e "\e[31m Create Nginx Reverse Proxy Configuration \e[0m"
cp /root/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[31m starting NGINX server\e[0m"
systemctl restart nginx