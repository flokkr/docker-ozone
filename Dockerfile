ARG BASE=latest
FROM flokkr/base:${BASE}
ARG ARTIFACTDIR
ADD ${ARTIFACTDIR} /opt/ozone
ENV CONF_DIR /opt/ozone/etc/hadoop
ENV PATH $PATH:/opt/ozone/bin
WORKDIR /opt/ozone
