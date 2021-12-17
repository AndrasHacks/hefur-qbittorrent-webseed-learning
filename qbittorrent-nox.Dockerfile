FROM ubuntu:focal
ENV PORT=8080


RUN apt-get update
RUN apt install -y software-properties-common
RUN apt-get update
RUN apt-add-repository -y ppa:qbittorrent-team/qbittorrent-stable
RUN apt install -y qbittorrent-nox

COPY qBittorrent.conf /root/.config/qBittorrent/

CMD qbittorrent-nox -d --webui-port=8080 && sleep infinity
