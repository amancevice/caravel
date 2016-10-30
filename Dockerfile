FROM debian:jessie
MAINTAINER smallweirdnum@gmail.com

# Install
ENV CARAVEL_VERSION 0.12.0
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        libssl-dev \
        libffi-dev \
        python3-dev \
        python3-pip \
        libsasl2-dev \
        libldap2-dev \
        python-mysqldb \
        curl && \
    pip3 install cryptography==1.4 && \
    pip3 install \
        caravel==$CARAVEL_VERSION \
        mysqlclient==1.3.7 \
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
RUN groupadd caravel && \
    useradd -g caravel caravel && \
    chown -R caravel:caravel /home/caravel
USER caravel

# Deploy
EXPOSE 8088
HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]
ENTRYPOINT ["caravel"]
CMD ["runserver"]
