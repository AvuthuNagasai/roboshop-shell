cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

dnf install mongodb-org -y &>>/tmp/roboshop.log




systemctl enable mongod &>>/tmp/roboshop.log
systemctl start mongod &>>/tmp/roboshop.log
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

systemctl restart mongod &>>/tmp/roboshop.log