# Caravel

Docker image for AirBnB's Caravel.

## Setup

Determine where you will store Caravel's database. In this example we will store a SQLite DB on our host machine in `~/caravel` and mount the directory to `/caravel` in the container. The default URI for the DB is `sqlite:////caravel/caravel.db`, but this can be modified.

```bash
# Start the caravel container
docker run --detach --name caravel \
    --publish 8088:8088 \
    --volume ~/caravel:/caravel \
    amancevice/caravel caravel runserver

# Create an admin user
docker exec -it caravel fabmanager create-admin --app caravel

# Initialize the database
docker exec caravel caravel db upgrade

# Create default roles and permissions
docker exec caravel caravel init
```
