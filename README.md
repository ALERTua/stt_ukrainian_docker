[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct-single.svg)](https://stand-with-ukraine.pp.ua)
[![Made in Ukraine](https://img.shields.io/badge/made_in-Ukraine-ffd700.svg?labelColor=0057b7)](https://stand-with-ukraine.pp.ua)
[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
[![Russian Warship Go Fuck Yourself](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/RussianWarship.svg)](https://stand-with-ukraine.pp.ua)


## Docker container for Ukrainian Speech to Text inference Gradio app

Repository: https://github.com/ALERTua/stt_ukrainian_docker

GitHub Docker Registry: https://github.com/ALERTua/stt_ukrainian_docker/pkgs/container/stt_ukrainian_docker

Docker Hub: https://hub.docker.com/r/alertua/stt_ukrainian_docker


### Description

Docker image for a gradio app that produces text from Ukrainian speech.

Used with https://github.com/ALERTua/stt-ukrainian-api to provide an OpenAI STT API endpoint to use it with Home Assistant.

I'll try to base this image on the most modern and effective SST model.
This image is currently based on: [Yehor/w2v-bert-uk-v2.1](https://huggingface.co/spaces/Yehor/w2v-bert-uk-v2.1)


### Deployment

The best way is to use the [docker-compose.yml](https://github.com/ALERTua/stt_ukrainian_docker/blob/main/docker-compose.yml)

Or run directly with Docker:
```bash
docker run -d \
  -p 7860:7860 \
  -v ./docker_volumes/stt/data:/data \
  --name stt_ukrainian \
  ghcr.io/alertua/stt_ukrainian_docker:latest
```


#### Gradio Web UI

You can access the Gradio Web UI at `http://{container_ip}:7860`


### /data volume structure
After the first run the data directory will look like this:

- `.cache` - contains models downloaded from HuggingFace Hub. ~2.4GB
- `uv_cache` - cache for installing prerequisites ~7.2gb
- `venv` - working environment ~7.4gb


### Resources usage
- tag `latest` uses ~3 GiB of RAM


### Things to do that I have no knowledge on (help appreciated)

- [ ] Make this use less RAM


### Things to do that depend on the author's code

- [ ] dummy


### Caveats

- The first start is slow as the models are downloaded and the prerequisites get installed.
