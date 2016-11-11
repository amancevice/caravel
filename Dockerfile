FROM amancevice/pandas:0.18.1-python3
MAINTAINER smallweirdnum@gmail.com

# Install
ENV CARAVEL_VERSION 0.13.1
RUN apk add --no-cache \
        curl \
        libffi-dev \
        cyrus-sasl-dev \
        mariadb-dev \
        postgresql-dev && \
    pip3 install \
        caravel==$CARAVEL_VERSION \
        mysqlclient==1.3.7 \
        psycopg2==2.6.1 \
        redis==2.10.5 \
        sqlalchemy-redshift==0.5.0

# Default config
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=$PATH:/home/caravel/.bin \
    PYTHONPATH=/home/caravel/caravel_config.py:$PYTHONPATH

# Run as caravel user
WORKDIR /home/caravel
COPY caravel .
RUN addgroup caravel && \
    adduser -h /home/caravel -G caravel -D caravel && \
    mkdir /home/caravel/db && \
    chown -R caravel:caravel /home/caravel
USER caravel

# Deploy
EXPOSE 8088
HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]
ENTRYPOINT ["caravel"]
CMD ["runserver"]
