FROM debian:stretch-slim

# Set java enviroment
ENV LANG=C.UTF-8 \
        JAVA_MAJOR_VERSION=11 \
        JAVA_MINOR_VERSION=0 \
        JAVA_UPDATE=19 \
        JAVA_TYPE=jdk

ENV JAVA_FULL_VERSION="${JAVA_MAJOR_VERSION}.${JAVA_MINOR_VERSION}.${JAVA_UPDATE}"

ENV JAVA_HOME="/opt/java/${JAVA_TYPE}-${JAVA_FULL_VERSION}" \
        JAVA_TAR="${JAVA_TYPE}-${JAVA_FULL_VERSION}_linux-x64_bin.tar.gz"

COPY  $JAVA_TAR  /tmp/$JAVA_TAR

# Downloading oracle jdk -> extract it -> cleanup -> add app user & group
# You can use USER called 'app' for your application
RUN cd /tmp \
#        && apt-get update \
        && mkdir -p $JAVA_HOME \
        && tar -xzf $JAVA_TAR -C /opt/java \
        && ln -s $JAVA_HOME $JAVA_HOME/bin/* /usr/bin/ \
        && rm -rf $JAVA_HOME/lib/src.zip \
        $JAVA_HOME/lib/missioncontrol \
        $JAVA_HOME/lib/*javafx* \
        $JAVA_HOME/lib/*jfx* \
        $JAVA_HOME/lib/*awt* \
        $JAVA_HOME/lib/desktop \
        $JAVA_HOME/lib/javaws.jar \
        $JAVA_HOME/lib/plugin.jar \
        $JAVA_HOME/lib/plugin-legacy.jar \
        $JAVA_HOME/lib/javaws.jar \
        $JAVA_HOME/lib/desktop \
        $JAVA_HOME/lib/deploy \
        $JAVA_HOME/lib/deploy* \
        $JAVA_HOME/lib/fonts \
        $JAVA_HOME/lib/oblique-fonts \
        $JAVA_HOME/jmods \
    && apt-get clean -y \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apt/archives/* \
        && useradd -ms /bin/bash app

# Add java to path
ENV PATH $PATH:$JAVA_HOME/bin
