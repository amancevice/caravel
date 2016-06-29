FROM amancevice/pandas:0.18.1-python3
MAINTAINER smallweirdnum@gmail.com

# Install
ENV CARAVEL_VERSION 0.10.0
RUN apk add --no-cache \
        curl \
        g++ \
        libffi-dev \
        mariadb-dev \
        postgresql-dev && \
    pip3 install \
        caravel==$CARAVEL_VERSION \
        mysqlclient==1.3.7 \
        psycopg2==2.6.1 \
        sqlalchemy-redshift==0.5.0

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
RUN addgroup caravel && \
    adduser -h /home/caravel -G caravel -D caravel && \
    mkdir /home/caravel/db && \
    chown -R caravel:caravel /home/caravel
WORKDIR /home/caravel
USER caravel

EXPOSE 8088

#HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]

CMD ["caravel", "runserver"]
