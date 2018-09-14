FROM hypriot/rpi-alpine
RUN apk update && apk add bash wget
COPY duckdns.sh /duckdns.sh
CMD /bin/bash /duckdns.sh