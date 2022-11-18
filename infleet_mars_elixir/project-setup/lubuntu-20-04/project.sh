
sudo su
# db docker config
cat /etc/hosts | grep db || echo "127.0.0.1 db" >> /etc/hosts
exit
