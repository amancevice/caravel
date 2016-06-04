#!/bin/bash

# Start Caravel
docker run --detach --name caravel \
    --env SECRET_KEY=mySUPERsecretKEY \
    --env SQLALCHEMY_DATABASE_URI="sqlite:////tmp/caravel.db" \
    --publish 8088:8088 \
    amancevice/caravel

# Set up caravel
docker exec -it caravel caravel-init
