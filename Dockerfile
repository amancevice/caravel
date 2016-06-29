FROM ubuntu:14.04
MAINTAINER amancevice@cargometrics.com

# Setup
RUN echo as of 2016-06-03 && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        curl \
        libssl-dev \
        libffi-dev \
        python-dev \
        python-pip \
        libmysqlclient-dev && \
    apt-get build-dep -y psycopg2

# Python
RUN pip install pip==8.1.2 \
    pandas==0.18.1 \
    mysqlclient==1.3.7 \
    psycopg2==2.6.1 \
    sqlalchemy-redshift==0.5.0 \
    caravel==0.10.0

# Default config
ENV CSRF_ENABLED=1 \
    DEBUG=0 \
    PATH=$PATH:/home/caravel/bin \
    PYTHONPATH=/home/caravel:$PYTHONPATH \
    ROW_LIMIT=5000 \
    SECRET_KEY='\2\1thisismyscretkey\1\2\e\y\y\h' \
    SQLALCHEMY_DATABASE_URI=sqlite:////home/caravel/db/caravel.db \
    WEBSERVER_THREADS=8

# Run as caravel user
RUN useradd -b /home -m -U caravel
COPY caravel /home/caravel
RUN mkdir /home/caravel/db && chown -R caravel:caravel /home/caravel
WORKDIR /home/caravel
USER caravel

EXPOSE 8088

#HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]

CMD ["caravel", "runserver"]
