FROM debian:jessie
MAINTAINER CiccioCX <ciccio.groucho@tiscali.it>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update
RUN apt-get -y install wget libc6 libglapi-mesa libxdamage1
RUN apt-get -y install libxfixes3 libxcb-glx0 libxcb-dri2-0 libxcb-dri3-0
RUN apt-get -y install libxcb-present0 libxcb-sync1 libxshmfence1 libxxf86vm1
RUN apt-get -qqy install ca-certificates curl python-gpgme

RUN cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

RUN apt-get -y install libc6 libglapi-mesa libxdamage1
RUN apt-get -y install libxfixes3 libxcb-glx0 libxcb-dri2-0 libxcb-dri3-0
RUN apt-get -y install libxcb-present0 libxcb-sync1 libxshmfence1 libxxf86vm1

# Perform image clean up.
RUN apt-get -qqy autoclean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/dbox/.dropbox", "/dbox/Dropbox"]
ENTRYPOINT ["~/.dropbox-dist/dropboxd"]