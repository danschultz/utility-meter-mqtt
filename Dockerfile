FROM alpine:3.17

RUN apk add --no-cache rtl-sdr mosquitto-clients

RUN apk add --no-cache go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN go install github.com/bemasher/rtlamr@latest

# https://mosquitto.org/man/mosquitto_pub-1.html
ENTRYPOINT ["mosquitto_pub", "--version"]
