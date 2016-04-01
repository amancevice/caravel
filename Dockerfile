FROM ubuntu:14.04
MAINTAINER amancevice@cargometrics.com

RUN echo as of 2016-04-01 && \
    apt-get update && \
    apt-get install -y build-essential libssl-dev libffi-dev python-dev python-pip

RUN pip install caravel

ENV ROW_LIMIT=5000 \
    WEBSERVER_THREADS=8 \
    SECRET_KEY=\2\1thisismyscretkey\1\2\e\y\y\h \
    SQLALCHEMY_DATABASE_URI=sqlite:////caravel/caravel.db \
    CSRF_ENABLED=1 \
    DEBUG=1 \
    PYTHONPATH=/caravel_config.py:$PYTHONPATH

COPY caravel_config.py /caravel_config.py


