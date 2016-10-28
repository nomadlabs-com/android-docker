FROM openjdk:8u102-jdk

ENV ANDROID_HOME /cache/android-sdk-linux
ENV GRADLE_USER_HOME /cache/.gradle

COPY licenses ${ANDROID_HOME}/licenses

COPY bin /usr/local/bin

ENV WORKSPACE /root/workspace
RUN mkdir -p "${WORKSPACE}"
WORKDIR ${WORKSPACE}
