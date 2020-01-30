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
docker run  -d  --name plex  --network=host  -e TZ="Europe/London"  -v ~/Documents/Docker/plex/database:/config  -v ~/Documents/Docker/plex/temp:/transcode  -v /:/Data --restart unless-stopped  plexinc/pms-docker:latest
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


echo "INSTALLING SONARR"
{
docker create   --name=sonarr   -e PUID=1000   -e PGID=1000   -e TZ=Europe/London   -e UMASK_SET=022  -p 8989:8989   -v ~/Documents/Docker/sonarr/data:/config   -v /:/Data   --restart unless-stopped   linuxserver/sonarr:latest
}&> /dev/null

echo "INSTALLING RADARR"
{
docker create   --name=radarr   -e PUID=1000   -e PGID=1000   -e TZ=Europe/London   -e UMASK_SET=022    -p 7878:7878   -v ~/Documents/Docker/radarr/data:/config   -v /:/Data   --restart unless-stopped 
}&> /dev/null

echo "INSTALLING qBittorrent"
{
docker create   --name=qbittorrent   -e PUID=1000   -e PGID=1000   -e TZ=Europe/London   -e UMASK_SET=022   -e WEBUI_PORT=8080   -p 6881:6881   -p 6881:6881/udp   -p 8080:8080   -v ~/Documents/Docker/qbittorrent/config:/config   -v /:/Data   --restart unless-stopped   linuxserver/qbittorrent:latest
}&> /dev/null

echo "INSTALLING SABnzbd"
{
docker create   --name=sabnzbd   -e PUID=1000   -e PGID=1000   -e TZ=Europe/London   -p 8080:8080   -p 9090:9090   -v ~/Documents/Docker/sabnzbd/data:/config   -v /:/Data   --restart unless-stopped   linuxserver/sabnzbd:latest
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

Portainer: http://127.0.0.1:9000

Plex: http://127.0.0.1:32400/web 
Sonarr: http://127.0.0.1:8989
Radarr: http://127.0.0.1:7878
qBittorrent: http://127.0.0.1:8080
SABnzbd: http://127.0.0.1:9090

If you have installed this on a 'headless pc' you will be able to access these services on your network from.

Portainer: http://(hostname -I | awk '{ print $1 }'):9000

Plex: http://(hostname -I | awk '{ print $1 }'):32400/web 
Sonarr: http://(hostname -I | awk '{ print $1 }'):8989
Radarr: http://(hostname -I | awk '{ print $1 }'):7878
qBittorrent: http://(hostname -I | awk '{ print $1 }'):8080
SABnzbd: http://(hostname -I | awk '{ print $1 }'):9090

To set up Rclone simply type 

sudo rclone config
"
