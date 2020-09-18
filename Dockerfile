ARG BASE=latest
FROM golang:1.14.2-buster
RUN GO111MODULE=off go get -u github.com/rexray/gocsi/csc

FROM flokkr/base:${BASE}
ARG ARTIFACTDIR
RUN alternatives --set java java-latest-openjdk.x86_64

# CSI / k8s / fuse / goofys dependency
RUN wget https://github.com/kahing/goofys/releases/download/v0.20.0/goofys -O /usr/bin/goofys
RUN chmod 755 /usr/bin/goofys
RUN yum install -y fuse

COPY --from=0 /go/bin/csc /usr/bin/csc

ADD ${ARTIFACTDIR} /opt/ozone
ENV CONF_DIR /opt/ozone/etc/hadoop
ENV PATH $PATH:/opt/ozone/bin
WORKDIR /opt/ozone
