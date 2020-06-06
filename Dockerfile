FROM debian:jessie

MAINTAINER Ciccio CX <ciccio.groucho@tiscali.it>

# This project is a fork of https://github.com/excelsiord/docker-dropbox.git

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update && apt-get -qqy install wget python3 sudo wget libglib2.0-0 libc6 \
  libglapi-mesa libxdamage1 libxfixes3 libxcb-glx0 libxcb-dri2-0 \
  libxcb-dri3-0 libxcb-present0 libxcb-sync1 libxshmfence1 libxxf86vm1 && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create service account and set permissions.
RUN useradd -d /dbox -c "Dropbox Daemon Account" -s /usr/sbin/nologin dropbox
RUN mkdir -p /dbox/.dropbox /dbox/.dropbox-dist /dbox/Dropbox /dbox/base

# Download & install current version of dropbox.
RUN wget -nv -O /dbox/base/dropbox.tar.gz "https://www.dropbox.com/download?plat=lnx.x86_64"
RUN wget -nv -O /dbox/dropbox.py "https://www.dropbox.com/download?dl=packages/dropbox.py"

# Perform image clean up.
RUN apt-get -qqy autoclean

# Set permissions
RUN chown -R dropbox /dbox

# Install script for managing dropbox init.
COPY dropbox-start.sh /dbox/
COPY dropbox /usr/local/bin/
RUN chmod +x /dbox/dropbox-start.sh /usr/local/bin/dropbox /dbox/dropbox.py

VOLUME ["/dbox/.dropbox", "/dbox/.dropbox-dist", "/dbox/Dropbox"]

# Dropbox Lan-sync
EXPOSE 17500

CMD ["/dbox/dropbox-start.sh"]