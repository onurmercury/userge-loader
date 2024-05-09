# onurmercury's userge-loader fork
A minimal & lightweight Userge loader.

## Differences from the upstream
- Container images are now available at [Docker Hub](https://hub.docker.com/r/onurmercury/userge-loader) and [GitHub Container registry]().
- Switched to Pyrofork from Pyrogram.
- Switched to a lighter base image.
- Node.js and Google Chrome are excluded from the image.
- PyPI package versioning issues are resolved.
- Switched to static builds of FFmpeg to avoid graphical dependencies.
- Initial boot time is reduced. (Plugin dependencies are now provided with the image.)
- The non-free APT repository is enabled.

## Run the bot
- Install [Docker Engine and Compose plugin](https://docs.docker.com/engine/install).
- Download [config_sample.env](config_sample.env) and [compose.yaml](compose.yaml) files to an empty folder.
- Fill `config_sample.env` and rename it as `config.env`.
- Open a shell inside that folder and run `docker compose up -d`.
- Deployment should be done, send `.help` to a Telegram chat to check the bot. If the bot is unresponsive after a few tries, check the logs.

### Useful commands
- Add Userge plugins to the bot (send to a Telegram chat): `.addrepo https://github.com/UsergeTeam/Userge-Plugins`
- Check the logs: `docker compose logs -f`
- Check the status of the container: `docker compose ps -a`
- Stop / Restart / Delete the container: `docker compose stop|restart|down -t 0`
- Start the container: `docker compose start`
- Delete both the container and the image: `docker compose down -t 0 --rmi all`

### Notes
- Note that some distros (Debian/Ubuntu) offer old version of Docker components, thus it is recommended to install Docker from its official website.
- If you prefer to install plugin dependencies on initial boot, suffix `docker compose` with `-f compose.basic.yaml`. (eg. `docker compose -f compose.basic.yaml up -d`)
- Some `docker` commands may require `sudo` to be prefixed to the commands.
- Node.js and Google Chrome dependent plugins (`video_chat` and `webss`) will not work. The `carbon` plugin may work using its fallback method.
- If you want to use GitHub Container registry instead of Docker Hub, uncomment `ghcr.io` and comment out the `docker.io` line in `compose.yaml`.