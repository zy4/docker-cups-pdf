FROM ubuntu:17.10
MAINTAINER Seung-Zin Nam "z.nam@envisia.de"

RUN apt-get --quiet update && apt-get --quiet --assume-yes --allow-downgrades --allow-remove-essential --allow-change-held-packages dist-upgrade

# Install cups
RUN apt-get install --quiet --assume-yes --allow-downgrades --allow-remove-essential --allow-change-held-packages cups printer-driver-hpcups printer-driver-cups-pdf


COPY cupsd.conf /etc/cups/cupsd.conf

EXPOSE 631

CMD ["/usr/sbin/cupsd", "-f"]

