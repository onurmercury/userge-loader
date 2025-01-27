# Minimal Userge Loader
A minimal and lightweight Userge loader as a Docker Hub image.

## Differences from the upstream
- Uses a slim variant of Debian Stable image as its base.
- Node.js and Google Chrome are dropped.
- Issues caused by Python package versions have been resolved.
- Uses a static build of FFmpeg to drop X11 dependencies.
- Comes with the Python packages required by official Userge plugins.
- Non-free APT repositories are enabled.
- Base image and APT are now container-friendly (non-interactive).

## Run the bot
- Install the [Docker Engine & Docker Compose plugin](https://docs.docker.com/engine/install).
- Download the [config_sample.env](https://github.com/onurmercury/userge-loader/blob/master/config_sample.env) and [docker-compose.yml](https://github.com/onurmercury/userge-loader/blob/master/docker-compose.yml) files to an empty folder.
- Fill the `config_sample.env` and rename it as `config.env`.
- Open a terminal shell inside that folder and run the following command: `docker compose up --build -d`
- After deployment, send `.help` in Telegram to check if the bot is working.

### Useful commands
- Add official Userge plugins to the bot: `.addrepo https://github.com/UsergeTeam/Userge-Plugins`
- Check the logs: `docker compose logs -f -n 25`
- Check the status of the container: `docker compose ps -a`
- Stop the container: `docker compose stop -t 0`
- Start the container: `docker compose start`
- Restart the container: `docker compose restart -t 0`
- Delete the container: `docker compose down -t 0`
- Delete both the container and the image: `docker compose down -t 0 --rmi all`
- Add user to the `docker` group: `sudo usermod -aG docker $(whoami)`

### Notes
- You need to run `docker compose ...` commands in the folder where the `docker-compose.yml` is located.
- If you installed Docker from the repositories of your Linux distribution, you may need to use `docker-compose` instead of `docker compose`.
- Replace `:latest` with `:basic` in `docker-compose.yml` if you prefer to install the required Python packages of official plugins at the bot's boot time.
- To run some commands that use `docker`, you may need to add yourself to the `docker` group or use `sudo` as a prefix.
- Node.js and Google Chrome dependent plugins (`video_chat` and `webss`) won't work. The `carbon` plugin may work using its fallback method.
