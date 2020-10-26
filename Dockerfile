FROM janeczku/dropbox

MAINTAINER Ciccio CX <ciccio.groucho@tiscali.it>

RUN apt-get -qqy update && apt-get -qqy install wget python3 sudo wget libglib2.0-0 libc6 \
  libglapi-mesa libxdamage1 libxfixes3 libxcb-glx0 libxcb-dri2-0 \
  libxcb-dri3-0 libxcb-present0 libxcb-sync1 libxshmfence1 libxxf86vm1 && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*