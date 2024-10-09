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
mkdir -p "$HOME/.local/share/srv/docker/nginx/rootfs"
git clone "https://github.com/dockermgr/nginx" "$HOME/.local/share/CasjaysDev/dockermgr/nginx"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/nginx/rootfs/." "$HOME/.local/share/srv/docker/nginx/rootfs/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-nginx \
--hostname nginx \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-nginx/rootfs/data:/data:z" \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-nginx/rootfs/config:/config:z" \
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
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-nginx/rootfs/data:/data:z"
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-nginx/rootfs/config:/config:z"
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
