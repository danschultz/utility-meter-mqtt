FROM alpine:3.17

RUN apk add --no-cache bash jq rtl-sdr mosquitto-clients

RUN apk add --no-cache go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN go install github.com/bemasher/rtlamr@latest

COPY ./rtl-sdr.conf /etc/modprobe.d/rtl-sdr.conf

RUN mkdir /opt/app
COPY ./docker-entrypoint.sh /opt/app/
COPY ./filter.sh /opt/app
RUN chmod +x /opt/app/docker-entrypoint.sh

WORKDIR /opt/app

ENTRYPOINT ["./docker-entrypoint.sh"]

# https://mosquitto.org/man/mosquitto_pub-1.html
# ENTRYPOINT ["mosquitto_pub", "--version"]
