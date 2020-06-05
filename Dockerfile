FROM debian:jessie

MAINTAINER Ciccio CX <ciccio.groucho@tiscali.it>

ARG UNAME=dropboxuser
ARG UID=666
ARG GID=666
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
CMD /bin/bash

# Install Python
RUN \
  apt-get update && \
  apt-get install -y python wget libglib2.0-0

RUN apt-get install -y libc6 libglapi-mesa libxdamage1 libxfixes3 libxcb-glx0 libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-sync1 libxshmfence1 libxxf86vm1

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN mkdir /dbox && chown -R $UNAME /dbox


#USER $UNAME
# Download and extract dropbox
RUN cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

RUN pwd


# Expose the Dropbox directory
VOLUME /root/Dropbox
VOLUME /root/.dropbox

# Setup the Dropbox CLI
#ADD https://www.dropbox.com/download?dl=packages/dropbox.py /scripts/dropbox.py
#RUN chmod 755 /scripts/dropbox.py

# Start the Dropbox daemon
ENTRYPOINT  /root/.dropbox-dist/dropboxd