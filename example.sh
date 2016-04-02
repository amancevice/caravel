#!/bin/bash

# Start Caravel
docker run --detach --name caravel \
    --env SECRET_KEY=mySUPERsecretKEY \
    --env SQLALCHEMY_DATABASE_URI=sqlite:////caravel/caravel.db \
    --publish 8088:8088 \
    amancevice/caravel

# Create an admin user
docker exec -it caravel fabmanager create-admin --app caravel

# Initialize the database
docker exec caravel caravel db upgrade

# Create default roles and permissions
docker exec caravel caravel init
