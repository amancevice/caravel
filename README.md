**NOTE** 

AirBnB renamed this project `superset`. As such this project is effectively dead. 

Find the new project at [amancevice/superset](https://github.com/amancevice/superset)

# Caravel

Docker image for [AirBnB's Caravel](https://github.com/airbnb/caravel).

As of version `0.10.0` this image is based on [Alpine Linux](https://alpinelinux.org/) and installed with [Python 3](https://docs.python.org/3/)


## Demo

Run the caravel demo by entering this command into your console:

```bash
docker run --name caravel -d -p 8088:8088 amancevice/caravel
docker exec -it caravel demo
```

You will be prompted to set up an admin user.

When finished navigate to [http://localhost:8088/](http://localhost:8088/) to see the demo.

Log in with the credentials you just created.


## Versions

This repo is tagged in parallel with caravel. Pulling `amancevice/caravel:0.10.0` will fetch the image of this repository running caravel version `0.10.0`. As it is an automated build, commits to the master branch of this repository trigger a re-build of the `latest` tag, while tagging master triggers a versioned build. It is possible that the `latest` tag includes new deployment-specific features but will usually be in sync with the latest semantic version.


## Database Setup

Determine where you will store Caravel's database; choose `SQLite`, `MySQL`, `PostgreSQL`, or `Redshift`. Use the `ENV` variable `SQLALCHEMY_DATABASE_URI` to point caravel to the correct database. Be sure to set a `SECRET_KEY` when creating the container.


#### SQLite

If Caravel's database is created using SQLite the db file should be mounted from the host machine. In this example we will store a SQLite DB on our host machine in `~/caravel/caravel.db` and mount the directory to `/home/caravel/db` in the container.

```bash
docker run --detach --name caravel \
    --env SECRET_KEY="mySUPERsecretKEY" \
    --env SQLALCHEMY_DATABASE_URI="sqlite:////home/caravel/db/caravel.db" \
    --publish 8088:8088 \
    --volume ~/caravel:/home/caravel/db \
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


#### Redshift

```bash
docker run --detach --name caravel \
    --env SECRET_KEY="mySUPERsecretKEY" \
    --env SQLALCHEMY_DATABASE_URI="redshift+psycopg2://username@host.amazonaws.com:5439/db" \
    --publish 8088:8088 \
    amancevice/caravel
```


## Database Initialization

After starting the Caravel server, initialize the database with an admin user and Caravel tables using the `caravel-init` helper script:

```bash
docker run --detach --name caravel ... amancevice/caravel
docker exec -it caravel caravel-init
```


## Upgrading

Upgrading to a newer version of caravel can be accomplished by re-pulling `amancevice/caravel`at a specified caravel version or `latest` (see above for more on this). Remove the old container and re-deploy, making sure to use the correct environmental configuration. Finally, ensure the caravel database is migrated up to the head:

```bash
# Pull desired version
docker pull amancevice/caravel

# Remove the current container
docker rm -f caravel-old

# Deploy a new container ...
docker run --detach --name caravel-new ...

# Upgrade the DB
docker exec caravel-new db upgrade
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
