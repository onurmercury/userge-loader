FROM python:3.9-slim

ARG TARGETPLATFORM

ENV DEBIAN_FRONTEND=noninteractive \
    NO_COLOR=1

COPY . /app

WORKDIR /app

RUN set -eux; \
        \
        printf '%s\n' 'APT::Install-Recommends "0";' 'DPkg::Progress-Fancy "0";' 'quiet "2";' > /etc/apt/apt.conf.d/minimised-apt; \
        sed -i 's/^Components: main$/Components: main non-free/' /etc/apt/sources.list.d/debian.sources; \
        \
        apt-get update; \
        apt-get install \
            curl wget \
            git gnupg \
            zip unzip \
            unrar xz-utils \
        ; \
        rm -rf /var/lib/apt/lists/*; \
        \
        case "$TARGETPLATFORM" in \
            "linux/amd64") arch="amd64" ;; \
            "linux/386") arch="i686" ;; \
            "linux/arm64") arch="arm64" ;; \
            "linux/arm/v7") arch="armhf" ;; \
            "linux/arm/v5") arch="armel" ;; \
        esac; \
        curl -LSfs "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-$arch-static.tar.xz" | \
            tar -xJC /usr/local/bin --no-same-owner --transform='s/.*\///' --wildcards \
                "ffmpeg-*-$arch-static/ffmpeg" \
                "ffmpeg-*-$arch-static/ffprobe" \
        ; \
        apt-get purge --auto-remove xz-utils; \
        \
        pip install -Ur requirements.txt --no-cache-dir

RUN bash ./install_plugin_deps

CMD ["bash", "./run"]
