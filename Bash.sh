#!/bin/bash

echo "Updating System "
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

echo "INSTALLING Docker Services"
{
curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker ${USER}
mkdir ~/docker
setfacl -Rdm g:docker:rwx ~/docker
chmod -R 775 ~/docker
} &> /dev/null
docker-compose -f ~/Media-Server-with-Docker-Ubuntu/docker-compose.yml up -d

echo "INSTALLING PLEX "
{
docker run  -d  --name plex  --network=host  -e TZ="Europe/London"  -v ~/Documents/Docker/plex/database:/config  -v ~/Documents/Docker/plex/temp:/transcode  -v /:/Data --restart unless-stopped  plexinc/pms-docker:latest
}&> /dev/null


echo "Adjusting the firewall"
{
iptables -A INPUT -p tcp -d 0/0 -s 0/0 --dport 32400 -j ACCEPT
}&> /dev/null



echo "Starting her up for you chief"
{
docker start $(docker ps -q) 
}&> /dev/null


echo "ALL DONE"
echo "ALL DONE"
echo "ALL DONE"
echo "Your new Docker services are up and running
You can access this from this PC through THE FOLLOWING ADDRESS:
___________________________________________________________________
Portainer: http://127.0.0.1:9000 - Docker Management User Interface.
Plex: http://127.0.0.1:32400/web -  Your personal media play.
Sonarr: http://127.0.0.1:8989 - Sonarr is a multi-platform app to search, download, and manage TV shows.
Radarr: http://127.0.0.1:7878 - Like Sonarr but for movies.
qBittorrent: http://127.0.0.1:8080 - qBittorrent is a cross-platform free and open-source BitTorrent client.
SABnzbd: http://127.0.0.1:8888 - SABnzbd is a binary newsgroup downloader. The program simplifies the downloading verifying and extracting of files from Usenet.
Jackett: http://127.0.0.1:9117 - Jackett is a mass torrent indexer scraper.
___________________________________________________________________
If you have installed this on a 'headless pc' or on a VPS you
will be able to access these services from the IP" 
(hostname -I | awk '{ print $1 }')

echo "We are finished here, for those that would like to config Rclone 
simply type, 
sudo rclone config
if you do not know what what Rclone is do not worry about it. 
Happy Watching 
"
