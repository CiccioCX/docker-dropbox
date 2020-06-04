FROM janeczku:dropbox
MAINTAINER CiccioCX <ckiccio.groucho@tiscali.it>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy install libc6 libglapi-mesa libxdamage1 libxfixes3 libxcb-glx0 libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-sync1 libxshmfence1 libxxf86vm1