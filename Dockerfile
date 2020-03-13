FROM ubuntu:bionic

ENV TZ=America/Sao_Paulo

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y make gcc-multilib libx11-dev:i386 libfreetype6-dev:i386 prelink wget bison flex software-properties-common xvfb fontconfig tzdata && \
	wget https://dl.winehq.org/wine/source/4.0/wine-4.0.2.tar.xz && \
    tar -xvf wine-4.0.2.tar.xz && \
    (cd wine-4.0.2/ ; ./configure ; make && make install) && \
    wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
    chmod +x winetricks && \
	mv winetricks /usr/local/bin && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get --only-upgrade install tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Reference: https://github.com/jfroom/docker-compose-rails-selenium-example
COPY ./files2docker/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
RUN chmod +x /docker-entrypoint.sh

 CMD ["/bin/bash"]