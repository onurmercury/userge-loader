# Minimal Userge Loader
A minimal and lightweight Userge loader.

## Differences between upstream
- Uses a slim variant of Debian as base.
- Comes without Node.js and Google Chrome.
- Fixed issues caused by Python package versions.
- Uses a static build of FFmpeg to drop X11 dependencies.
- Comes with Python packages required for official plugins.
- Enabled non-free APT repositories.
- Base image and APT have been made container friendly.

## Build the bot using Docker
- Install the [`docker engine`](https://docs.docker.com/engine/install/) and [`compose plugin`](https://docs.docker.com/compose/install/) if you haven't already.
- Download [`config_sample.env`](https://raw.githubusercontent.com/ripsivis/userge-loader/master/config_sample.env) and [`docker-compose.yml`](https://raw.githubusercontent.com/ripsivis/userge-loader/master/docker-compose.yml) files to an empty folder.
- Fill the `config_sample.env` and rename it as `config.env`.
- Open a terminal shell inside that folder and run `docker compose up -d --build`.
- Send `.help` in Telegram after installation to check if the bot works.

### Useful commands
- Add official Userge plugins to the bot: `.addrepo https://github.com/UsergeTeam/Userge-Plugins`
- Check logs: `watch "docker logs userge > head -n 25"`
- Check bot and container status: `docker ps -a | grep userge`
- Restart the bot: `docker restart userge`
- Start the bot: `docker start userge`
- Stop the bot: `docker stop userge`
- Delete the Userge container: `docker rm userge`
- Delete the Userge image: `docker rmi onurmercury/userge-loader`
- Add current user to the `docker` group: `sudo usermod -aG docker $(whoami)`

### Notes
- Replace `:latest` with `:basic` in `docker-compose.yml` if you prefer to install Python packages at bot's boot time.
- To be able to run some of the commands that use `docker`, add yourself to the `docker` group or prefix these commands with `sudo`.
- Node.js and Google Chrome dependent plugins (`video_chat` and `webss`) won't work. The `carbon` plugin may work using its fallback method.
