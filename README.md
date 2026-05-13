## 👋 Welcome to nginx 🚀  

nginx README  
  
  
## Install my system scripts  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 sudo systemmgr --config && sudo systemmgr install scripts  
```
  
## Automatic install/update  
  
```shell
dockermgr update nginx
```
  
## Install and run container
  
```shell
dockerHome="/var/lib/srv/$USER/docker/casjaysdevdocker/nginx/nginx/latest/rootfs"
mkdir -p "/var/lib/srv/$USER/docker/nginx/rootfs"
git clone "https://github.com/dockermgr/nginx" "$HOME/.local/share/CasjaysDev/dockermgr/nginx"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/nginx/rootfs/." "$dockerHome/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-nginx-latest \
--hostname nginx \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$dockerHome/data:/data:z" \
-v "$dockerHome/config:/config:z" \
-p 80:80 \
casjaysdevdocker/nginx:latest
```
  
## via docker-compose  
  
```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/nginx
    container_name: casjaysdevdocker-nginx
    environment:
      - TZ=America/New_York
      - HOSTNAME=nginx
    volumes:
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/nginx/nginx/latest/rootfs/data:/data:z"
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/nginx/nginx/latest/rootfs/config:/config:z"
    ports:
      - 80:80
    restart: always
```
  
## Get source files  
  
```shell
dockermgr download src casjaysdevdocker/nginx
```
  
OR
  
```shell
git clone "https://github.com/casjaysdevdocker/nginx" "$HOME/Projects/github/casjaysdevdocker/nginx"
```
  
## Build container  
  
```shell
cd "$HOME/Projects/github/casjaysdevdocker/nginx"
buildx 
```
  
## Authors  
  
🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵  
