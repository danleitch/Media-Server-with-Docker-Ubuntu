This is a single command that will install a Complete Media Center package - Plex, Sonarr, Radarr, SABnzbd, qBittorrent, Portainer, Watchtower & Rclone. Ubuntu in Docker.

Copy and Past this command into your terminal 
--> 

**sudo git clone https://github.com/Thunder-Chief/Media-Server-with-Docker-Ubuntu.git && cd Media-Server-with-Docker-Ubuntu && sudo bash Bash.sh**


Note:

1.On Portainer's first launch create a Username  & Password and select local. From this point look around for the tab that says containers it should be self-explanatory from there.

2.This Plex container will NOT support hardware transcoding - it can,  you would need to expose the correct hardware to your docker image but every PC is different that is why I left it out. Mine is up and running  well so i can confirm it works very well. I'm happy to share on request. 

3.This install is a stock standard install, no special programs here. Changing things would be as docker documentation says.


Good to know info.

To edit the docker-compose.yml file 
**sudo nano ~/Media-Server-with-Docker-Ubuntu/docker-compose.yml**

to launch it
**sudo docker-compose -f ~/Media-Server-with-Docker-Ubuntu/docker-compose.yml up -d**

Also the great news about this install is that it is too easy to backup.
First off shutdown the program you wish to back up 
Then go to **~/Documents/Docker** and copy the program file to wherever you like. 

________________________________________________________________________________

Portainer: **http://127.0.0.1:9000** - Docker Management User Interface.

Plex: **http://127.0.0.1:32400/web** -  Your personal media player.

Sonarr: **http://127.0.0.1:8989** - Sonarr is a multi-platform app to search, download, and manage TV shows.

Radarr: **http://127.0.0.1:7878** - Like Sonarr but for movies.

qBittorrent: **http://127.0.0.1:8086** - qBittorrent is a cross-platform free and open-source BitTorrent client.

SABnzbd: **http://127.0.0.1:8888** - SABnzbd is a binary newsgroup downloader. The program simplifies the downloading verifying and extracting of files from Usenet.

Jackett: **http://127.0.0.1:9117** - Jackett is a mass torrent indexer scraper.
________________________________________________________________________________

Date: 2020/01

This was tested on 

DigitalOcean - Ubuntu 18.04.3 (LTS) x64

Local Virtual Machine - Ubuntu Server 18.04 (LTS) x64
