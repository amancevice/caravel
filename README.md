# Caravel

Docker image for [AirBnB's Caravel](https://github.com/airbnb/caravel).


## Run Demo

Run the caravel demo by entering this command into your console:

```bash
docker run --rm --interactive --tty --publish 8088:8088 amancevice/caravel ./demo
```

You will be prompted to create an admin user. When finished navigate to [http://localhost:8088/](http://localhost:8088/) to see the demo.


## Versions

This repo is tagged in parallel with caravel. Pulling `amancevice/caravel:0.8.9` will fetch the image of this repository running caravel v0.8.9. As it is an automated build, commits to the master branch of this repository trigger a re-build of the `latest` tag, while tagging master triggers a versioned build. It is possible that the `latest` tag includes new deployment-specific features but will usually be in sync with the latest semantic version. Use either method to deploy caravel, being aware of the caveats with `latest`.


## Database Setup

Determine where you will store Caravel's database; choose `SQLite`, `MySQL`, or `PostgreSQL`. Use the `ENV` variable `SQLALCHEMY_DATABASE_URI` to point caravel to the correct database. Be sure to set a `SECRET_KEY` when creating the container.


#### SQLite

If Caravel's database is created using SQLite the db file should be mounted from the host machine. In this example we will store a SQLite DB on our host machine in `~/caravel/caravel.db` and mount the directory to `/home/caravel` in the container.

```bash
docker run --detach --name caravel \
    --env SECRET_KEY="mySUPERsecretKEY" \
    --env SQLALCHEMY_DATABASE_URI="sqlite:////home/caravel/caravel.db" \
    --publish 8088:8088 \
    --volume ~/caravel/caravel.db:/home/caravel/caravel.db \
    amancevice/caravel
```


#### MySQL

```bash
docker run --detach --name caravel \
    --env SECRET_KEY="mySUPERsecretKEY" \
    --env SQLALCHEMY_DATABASE_URI="mysql://user:pass@host:port/db" \
    --publish 8088:8088 \
    amancevice/caravel
```


#### PostgreSQL

```bash
docker run --detach --name caravel \
    --env SECRET_KEY="mySUPERsecretKEY" \
    --env SQLALCHEMY_DATABASE_URI="postgresql://user:pass@host:port/db" \
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


## Upgrading

Upgrading to a newer version of caravel can be accomplished by re-pulling `amancevice/caravel`at a specified caravel version or `latest` (see above for more on this). Remove the old container and re-deploy, making sure to use the correct environmental configuration. Finally, ensure the caravel database is migrated up to the head:

```bash
# Pull desired version
docker pull amancevice/caravel

# Remove the current container
docker rm -f caravel

# Deploy a new container ...
docker run --detach --name caravel ...

# Upgrade the DB
docker exec caravel caravel db upgrade
```


## Additional Configuration

A custom configuration can be accomplished through mounting a Caravel config to `~caravel/caravel_config.py` in the container or by setting `ENV` variables:
* `ROW_LIMIT`
* `WEBSERVER_THREADS`
* `SECRET_KEY`
* `SQLALCHEMY_DATABASE_URI`
* `CSRF_ENABLED`
* `DEBUG`

Additional environmental variables prefixed with `CARAVEL_` will also be passed to the caravel configuration (without the `CARAVEL_` prefix). See the [caravel configuration file](https://github.com/airbnb/caravel/blob/master/caravel/config.py) for a list of available configuration keys. 

For example, the following command will deploy caravel with the [`LOG_LEVEL`](https://github.com/airbnb/caravel/blob/master/caravel/config.py) variable set in the caravel configuration:

```bash
docker run --detach --name caravel \
    --env CARAVEL_LOG_LEVEL="INFO" \
    --publish 8088:8088 \
    amancevice/caravel
```
