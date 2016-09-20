FROM amancevice/caravel
MAINTAINER smallweirdnum@gmail.com

USER root
RUN apk add --no-cache git nodejs
RUN git clone https://github.com/airbnb/caravel.git
RUN cd caravel/caravel/assets && npm install && npm run prod
RUN cd caravel && python3 setup.py install
USER caravel
