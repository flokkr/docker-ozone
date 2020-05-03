ARG BASE=latest
ARG ARTIFACTDIR
FROM flokkr/base:${BASE}
RUN alternatives --set java java-latest-openjdk.x86_64
ADD ${ARTIFACTDIR} /opt/ozone
ENV CONF_DIR /opt/ozone/etc/hadoop
ENV PATH $PATH:/opt/ozone/bin
WORKDIR /opt/ozone
