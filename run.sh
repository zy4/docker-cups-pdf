#!/bin/bash

name="cups"
cid="$(docker ps -q --filter "name=${name}")"
if [ -n "${cid}" ]; then
	echo "Stopping container..."
	docker stop "${name}" > /dev/null
fi
cid="$(docker ps -a -q --filter "name=${name}")"
if [ -n "${cid}" ]; then
	echo "Removing container..."
	docker rm "${name}" > /dev/null
fi

echo "Running container..."
docker run --name ${name} --detach --restart=always --privileged --volume /dev/bus/usb:/dev/bus/usb --publish 6632:631 ${name}

docker exec -it ${name} lpadmin -p cups-pdf -v cups-pdf:/ -E -P /usr/share/ppd/cups-pdf/CUPS-PDF_opt.ppd
