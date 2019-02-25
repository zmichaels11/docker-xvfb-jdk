FROM zmichaels/xvfb:latest

# Mostly based on https://github.com/AdoptOpenJDK/openjdk-docker/blob/master/11/jdk/ubuntu/Dockerfile.hotspot.releases.full

RUN apt-get update -q \
  && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/* \
  && curl -Lso /tmp/openjdk.tar.gz "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.2%2B7/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_7.tar.gz"; \
  mkdir -p /opt/java/openjdk; \
  cd /opt/java/openjdk; \
  tar -xf /tmp/openjdk.tar.gz; \
  jdir=$(dirname $(dirname $(find /opt/java/openjdk -name javac))); \
  mv ${jdir}/* /opt/java/openjdk; \
  rm -rf ${jdir} /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
  PATH="/opt/java/openjdk/bin:$PATH" \
  JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport"
