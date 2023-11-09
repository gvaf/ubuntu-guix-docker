FROM ubuntu:22.0

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y supervisor
RUN apt-get install -y wget
RUN apt-get install -y gpg
RUN apt-get install -y xz-utils
RUN apt-get install -y nscd
RUN apt-get install -y netbase
RUN apt-get install -y vim

COPY guix-daemon.conf /etc/supervisor/conf.d/guix-daemon.conf

COPY nscd.conf /etc/supervisor/conf.d/nscd.conf

COPY guix-install.sh /tmp/guix-install.sh
RUN chmod +x /tmp/guix-install.sh
RUN /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

ENV GUIX_PROFILE="/root/.config/guix/current"
# . "$GUIX_PROFILE/etc/profile"

CMD ["/bin/bash"]
