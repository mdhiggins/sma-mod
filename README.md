# sma-mod
Docker-mod container for that adds FFmpeg and SMA to linuxserver containers. Compatible with Ubuntu and Alpine based containers

See https://github.com/linuxserver/docker-mods for application

## Usage
Docker mods are applied but setting the `DOCKER_MODS` environment variable

### docker-compose sample

~~~yml
sabnzbd:
  image: ghcr.io/linuxserver/sabnzbd
  container_name: sabnzbd
  environment:
    - PUID=${PUID}
    - PGID=${PGID}
    - DOCKER_MODS=mdhiggins/sma-mod:latest
volumes:
    #- /opt/appdata/sabnzbd:/config
    #- /mnt/storage/downloads:/downloads #optional
    #- /opt/appdata/sma:/usr/local/sma/config
restart: unless-stopped
~~~

### autoProcess.ini

- Mount autoProcess.ini containing directory to `/usr/local/sma/config` using volumes
 - Consider making this writable as new options will be auto written to the config as they are added
- Sonarr/Radarr configuration options are read from `config.xml` inside the container and injected at runtime into `autoProcess.ini`
 - ffmpeg
 - ffprobe
 - host (read from environment variable or set to 127.0.0.1)
 - webroot
 - port
 - ssl

### Scripts
When you configure whatever container you are integrating to execute one the included python scripts, ensure that you are also pointing to the python virtual environment that contains its dependencies. Dependenies are not installed at the OS level. Many of the required wrappers are included and use the .sh extension (see the extras folder). If not that can be created manually but using the python executable `/usr/local/sma/venv/bin/python3`

### FFMPEG Binaries

- `/usr/local/bin/ffmpeg`
- `/usr/local/bin/ffprobe`

## Logs
Located at `/usr/local/sma/config/sma.log` inside the container and your mounted config folder

## Environment Variables

|Variable|Description|
|---|---|
|PUID|User ID|
|PGID|Group ID|
|HOST|Local IP address for callback requests, default `127.0.0.1`|
|SMA_PATH|`/usr/local/sma`|
|SMA_UPDATE|Default `false`. Set `true` to pull git update of SMA on restart|
|SMA_FFMPEG_URL|Defaults to latest static build from https://johnvansickle.com but can override by changing this var|
|SMA_STRIP_COMPONENTS|Default `1`. Number of components to strip from your tar.xz file when extracting so that FFmpeg binaries land in `/usr/local/bin`|
|SMA_HWACCEL|Default `false`. Set `true` to pull additional packages used for hardare acceleration (will require custom FFmpeg binaries)|
|SMA_USE_REPO|Default `false`. Set `true` to download FFMPEG binaries for default repository (will likely be older versions)|
