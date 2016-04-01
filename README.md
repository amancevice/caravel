# caravel
Docker image for caravel


```bash
docker run --rm -it --volume ~/caravel:/caravel amancevice/caravel fabmanager create-admin --app caravel
docker run --rm --volume ~/caravel:/caravel amancevice/caravel caravel db upgrade
docker run --rm --volume ~/caravel:/caravel amancevice/caravel caravel init
docker run --detach --port 8088:8088 --volume ~/caravel:/caravel amancevice/caravel caravel runserver
