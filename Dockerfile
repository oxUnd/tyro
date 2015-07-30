FROM ubuntu:14.04

MAINTAINER Dave Hulbert, dave1010@gmail.com

RUN apt-get update

RUN apt-get build-dep -y php5 && apt-get install -y \
    git \
    make \
    autoconf \
    build-essential \
    g++ \
    libc6-dev \
    vim \
    go

# PHP 7
RUN cd /opt && git clone https://github.com/php/php-src.git --depth=1
RUN cd /opt/php-src && ./buildconf --force
RUN cd /opt/php-src && ./configure --quiet \
    --prefix=/opt/php-nightly
RUN cd /opt/php-src && make --quiet
RUN cp /opt/php-src/sapi/cli/php /usr/local/bin/php

# vim
RUN git clone https://github.com/xiangshouding/vimrc.git ~/.vim_runtime && \
    sh ~/.vim_runtime/install_awesome_vimrc.sh

CMD ["/bin/bash"]