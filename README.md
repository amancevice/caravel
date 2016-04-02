# Caravel

Docker image for AirBnB's Caravel.


## Database Setup

Determine where you will store Caravel's database; choose `SQLite`, `MySQL`, or `PostgreSQL`. Use the `ENV` variable `SQLALCHEMY_DATABASE_URI` to point caravel to the correct database. Be sure to set a `SECRET_KEY` when creating the container.

If Caravel's database is created using SQLite the db file should be mounted from the host machine. In this example we will store a SQLite DB on our host machine in `~/caravel/caravel.db` and mount the directory to `/caravel` in the container.


#### SQLite

```bash
docker run --detach --name caravel \
    --env SECRET_KEY=mySUPERsecretKEY \
    --env SQLALCHEMY_DATABASE_URI=sqlite:////caravel/caravel.db \
    --publish 8088:8088 \
    --volume ~/caravel/caravel.db:/caravel/caravel.db \
    amancevice/caravel
```


#### MySQL

```bash
docker run --detach --name caravel \
    --env SECRET_KEY=mySUPERsecretKEY \
    --env SQLALCHEMY_DATABASE_URI=mysql://user:pass@host:port/db \
    --publish 8088:8088 \
    amancevice/caravel
```


#### PostgreSQL

```bash
docker run --detach --name caravel \
    --env SECRET_KEY=mySUPERsecretKEY \
    --env SQLALCHEMY_DATABASE_URI=postgresql://user:pass@host:port/db \
    --publish 8088:8088 \
    amancevice/caravel
```


## Database Initialization

After starting the Caravel server, initialize the database with an admin user and Caravel tables:

```bash
# Create an admin user
docker exec -it caravel fabmanager create-admin --app caravel

# Initialize the database
docker exec caravel caravel db upgrade

# Create default roles and permissions
docker exec caravel caravel init
```


## Additional Configuration

A custom configuration can be accomplished through mounting a Caravel config to `/caravel_config.py` in the container or by setting `ENV` variables:
* `ROW_LIMIT`
* `WEBSERVER_THREADS`
* `SECRET_KEY`
* `SQLALCHEMY_DATABASE_URI`
* `CSRF_ENABLED`
* `DEBUG`
