FROM alpine:latest

# set variables
ARG PB_VERSION=0.17.5
#ARG DOMAIN=example.com
ENV TZ="Europe/Stockholm"

# download tools
RUN apk add --no-cache unzip ca-certificates tzdata

# download and unzip PocketBase
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip -O /tmp/pb.zip
RUN mkdir /pb/ && unzip /tmp/pb.zip -d /pb/
RUN rm /tmp/pb.zip

# used ports
EXPOSE 8090
#EXPOSE 80 443

# start pocketbase
ENTRYPOINT ["/pb/pocketbase", "serve", "--http=0.0.0.0:8090"]
#CMD ["/pb/pocketbase", "serve", --http="$DOMAIN:80", https="$DOMAIN:443"]
