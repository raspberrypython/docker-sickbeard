FROM raspberrypython/base:latest
MAINTAINER David Noyes <david@raspberrypython.com>

ENV SICKBEARD_VERSION master

RUN groupadd --gid 1001 media && \
    useradd --no-create-home --uid 1001 --gid 1001 media

RUN apt-get -q update &&\
    apt-get install -qy --force-yes python-cheetah curl && \
    curl -L https://github.com/midgetspy/Sick-Beard/tarball/$SICKBEARD_VERSION -o sickbeard.tgz && \
    tar -xvf sickbeard.tgz -C / && \
    mv /midgetspy-Sick-Beard-* /sickbeard/ && \
    rm  /sickbeard.tgz && \
    chown -R media:media /sickbeard && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/config","/data","/Videos"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8081

USER media

CMD ["/start.sh"]
