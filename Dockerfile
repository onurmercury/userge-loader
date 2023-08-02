# set base image
FROM python:3.9-slim

# set working directory
WORKDIR /app/

# make debian container friendly
ENV DEBIAN_FRONTEND=noninteractive
ENV NO_COLOR=1

# make apt container friendly and enable non-free repos
RUN echo '\
APT::Get::Assume-Yes "1"; \n\
APT::Install-Recommends "0"; \n\
APT::Install-Suggests "0"; \n\
Binary::apt::APT::Color "0"; \n\
Binary::apt::DPkg::Progress-Fancy "0"; \n\
Binary::apt::DPkg::Use-Pty "0"; \n\
quiet "3";' > /etc/apt/apt.conf.d/999noninteractive && \
\
sed -i 's/Components: main/Components: main contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources

# install utilities
RUN apt-get update && \
    apt-get install \
    zip unzip \
    rar unrar \
    curl wget \
    git gnupg2 \
    \
    xz-utils && \
    wget -q -O - https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz | tar xJ && \
    install -Dm755 ffmpeg-git-*-amd64-static/ffmpeg /usr/local/bin/ffmpeg && \
    install -Dm755 ffmpeg-git-*-amd64-static/ffprobe /usr/local/bin/ffprobe && \
    rm -rf ffmpeg-git-*-amd64-static/ && \
    apt-get purge xz-utils && \
    \
    rm -rf /var/lib/apt/lists/*

# copy source to working directory
COPY . .

# install python packages for userge
RUN pip install -Uqr requirements.txt pip --no-cache-dir

# install python packages for userge plugins
RUN bash ./instPkgs

# command to start container
CMD [ "bash", "./run" ]
