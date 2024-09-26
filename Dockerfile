FROM python:3.9-slim-bookworm AS basic

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
            curl \
            wget \
            git \
            gnupg \
            zip \
            unzip \
            unrar \
            xz-utils \
        ; \
        curl -fsSL "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-${TARGETPLATFORM#*/}-static.tar.xz" | \
            tar -xJC /usr/local/bin --no-same-owner --transform='s/.*\///' --wildcards \
                "ffmpeg-*-${TARGETPLATFORM#*/}-static/ffmpeg" \
                "ffmpeg-*-${TARGETPLATFORM#*/}-static/ffprobe" \
        ; \
        pip install -Ur requirements.txt --no-cache-dir; \
        \
        apt-get purge --auto-remove xz-utils; \
        \
        rm -rf /var/lib/apt/lists/*

CMD ["sh", "./run"]

FROM basic AS with_plugins

RUN bash ./install_plugin_deps
