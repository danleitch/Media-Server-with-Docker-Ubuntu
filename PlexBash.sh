#!/bin/bash

echo "Updating Ubuntu "
{
apt-get update
apt-get upgrade -y 
} &> /dev/null

echo "Installing Docker for you" 
{
apt-transport-https ca-certificates curl software-properties-common -y 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 
apt-get update && apt-get install docker-ce -y 
usermod -aG docker ${USER} 
cd ~ ; pwd 
} &> /dev/null

echo "INSTALLING PLEX "
{
docker run  -d  --name plex  --network=host  -e TZ="Europe/London"  -v ~/Documents/Docker/plex/database:/config  -v ~/Documents/Docker/plex/temp:/transcode  -v /:/Media --restart unless-stopped  plexinc/pms-docker:latest
}&> /dev/null

echo "Adjusting the firewall"
{
iptables -A INPUT -p tcp -d 0/0 -s 0/0 --dport 32400 -j ACCEPT
}&> /dev/null


echo "INSTALLING WATCHTOWER"
{
docker run -d     --name watchtower     -v /var/run/docker.sock:/var/run/docker.sock     containrrr/watchtower
}&> /dev/null

echo "INSTALLING PORTIANER"
{
docker run -d -p 8000:8000 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
}&> /dev/null

echo "INSTALLING RCLONE"
{
curl https://rclone.org/install.sh | sudo bash
}&> /dev/null

echo "Starting her up for you chief"
{
docker start $(docker ps -q) 
}&> /dev/null


echo "ALL DONE"
echo "ALL DONE"
echo "ALL DONE"
echo " You will need to access your plex server and set it up remote access on it. In order to route through to it you will need to follow
my instructions open up the terminal on you pc your working on and copy
ssh -L 127.0.0.1:32400:127.0.0.1:32400 root@$(hostname -I | awk '{ print $1 }') 
Once you are in go through to 'Settings' then down to remote access and enable remote access.

That it you are now done. you can access you server through https://app.plex.tv
"




echo "Portainer's interface - http://$(hostname -I | awk '{ print $1 }'):9000"

#echo "Plex user address - http://$(hostname -I | awk '{ print $1 }'):32400"

