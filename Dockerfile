FROM resin/rpi-raspbian:latest

RUN apt-get update && \
    apt-get install -y build-essential libffi-dev libssl-dev \
                       python3 python3-dev python3-pip mysql-server && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install virtualenv

RUN virtualenv decaf

RUN /decaf/bin/pip3 install Flask Flask-RESTful Flask-MySQL simplejson RPi.GPIO

COPY ./ /var/www/decaf

WORKDIR /var/www/decaf

ENTRYPOINT /etc/init.d/mysql start && \
           mysql < db/mugsy.sql && \
           /decaf/bin/python3 decaf.py

