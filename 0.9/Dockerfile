FROM ubuntu:16.04
MAINTAINER smallweirdnum@gmail.com

# Setup
RUN echo as of 2016-06-29 && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        curl \
        libssl-dev \
        libffi-dev \
        python3-dev \
        python3-pip \
        libmysqlclient-dev && \
    apt-get build-dep -y psycopg2

# Python
RUN pip3 install \
        pandas==0.18.1 \
        mysqlclient==1.3.7 \
        psycopg2==2.6.1 \
        sqlalchemy-redshift==0.5.0 \
        caravel==0.9.1

# Default config
ENV CSRF_ENABLED=1 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=$PATH:/home/caravel/.bin \
    PYTHONPATH=/home/caravel:$PYTHONPATH \
    ROW_LIMIT=5000 \
    SECRET_KEY='\2\1thisismyscretkey\1\2\e\y\y\h' \
    SQLALCHEMY_DATABASE_URI=sqlite:////home/caravel/db/caravel.db \
    WEBSERVER_THREADS=8

# Run as caravel user
COPY caravel /home/caravel
RUN useradd -b /home -U caravel && \
    mkdir /home/caravel/db && \
    chown -R caravel:caravel /home/caravel
WORKDIR /home/caravel
USER caravel

EXPOSE 8088

#HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]

CMD ["caravel", "runserver"]
