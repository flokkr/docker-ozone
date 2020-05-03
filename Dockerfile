ARG BASE=latest
RUN alternatives --set java java-latest-openjdk.x86_64
FROM flokkr/base:${BASE}
ARG ARTIFACTDIR
ADD ${ARTIFACTDIR} /opt/ozone
ENV CONF_DIR /opt/ozone/etc/hadoop
ENV PATH $PATH:/opt/ozone/bin
WORKDIR /opt/ozone
