FROM ubuntu:14.04
MAINTAINER amancevice@cargometrics.com

RUN echo as of 2016-04-03 && \
    apt-get update && \
    apt-get install -y build-essential libssl-dev libffi-dev python-dev python-pip

# Caravel
RUN pip install caravel==0.8.4

# MySQL
RUN apt-get install -y libmysqlclient-dev && pip install mysql-python==1.2.5

# PostgreSQL
RUN apt-get build-dep -y psycopg2 && pip install psycopg2==2.6.1

EXPOSE 8088

# Default config
ENV ROW_LIMIT=5000 \
    WEBSERVER_THREADS=8 \
    SECRET_KEY=\2\1thisismyscretkey\1\2\e\y\y\h \
    SQLALCHEMY_DATABASE_URI=sqlite:////caravel/caravel.db \
    CSRF_ENABLED=1 \
    DEBUG=1 \
    PYTHONPATH=/caravel_config.py:$PYTHONPATH

COPY caravel_config.py /caravel_config.py
COPY caravel.db /caravel/caravel.db

CMD ["caravel", "runserver"]
