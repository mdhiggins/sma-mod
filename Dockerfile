## Buildstage ##
FROM ghcr.io/linuxserver/baseimage-ubuntu:focal as buildstage
LABEL maintainer="mdhiggins <mdhiggins23@gmail.com>"

ENV SMA_PATH /usr/local/sma
ENV SMA_UPDATE false
ENV SMA_FFMPEG_URL https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz

# get python3 and git, and install python libraries
RUN \
  apt-get update && \
  apt-get install -y \
    git \
    wget \
    python3 \
    python3-pip && \
# make directory
  mkdir -p ${SMA_PATH} && \
# download repo
  git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git ${SMA_PATH} && \
# install pip, venv, and set up a virtual self contained python environment
  python3 -m pip install --user --upgrade pip && \
  python3 -m pip install --user virtualenv && \
  python3 -m virtualenv ${SMA_PATH}/venv && \
  ${SMA_PATH}/venv/bin/pip install -r ${SMA_PATH}/setup/requirements.txt && \
  mv ${SMA_PATH} /root-layer${SMA_PATH} && \
# ffmpeg
  wget ${SMA_FFMPEG_URL} -O /tmp/ffmpeg.tar.xz && \
  mkdir -p /root-layer/usr/local/bin && \
  tar -xJf /tmp/ffmpeg.tar.xz -C /root-layer/usr/local/bin --strip-components 1 && \
  chgrp users /root-layer/usr/local/bin/ffmpeg && \
  chgrp users /root-layer/usr/local/bin/ffprobe && \
  chmod g+x /root-layer/usr/local/bin/ffmpeg && \
  chmod g+x /root-layer/usr/local/bin/ffprobe && \
# cleanup
  apt-get purge --auto-remove -y && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# update.py sets FFMPEG/FFPROBE paths, updates API key and Sonarr/Radarr settings in autoProcess.ini
COPY extras/ /root-layer${SMA_PATH}/
COPY root/ /root-layer/

FROM scratch

ENV SMA_PATH /usr/local/sma
ENV SMA_UPDATE false

VOLUME /usr/local/sma/config

COPY --from=buildstage /root-layer/ /