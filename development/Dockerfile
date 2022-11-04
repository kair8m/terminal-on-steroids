FROM ubuntu:latest

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -yy && apt-get install -yy \
    sudo \
    git \
    curl \
    wget

RUN adduser --disabled-password --gecos '' dev
RUN adduser dev sudo
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev
