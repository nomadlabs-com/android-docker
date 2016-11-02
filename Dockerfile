FROM openjdk:8u102-jdk

ENV ANDROID_HOME /cache/android-sdk-linux
ENV GRADLE_USER_HOME /cache/.gradle

ENV ANDROID_SDK_LICENSES /opt/licenses
COPY licenses ${ANDROID_SDK_LICENSES}
COPY licenses ${ANDROID_HOME}/licenses

COPY bin /usr/local/bin

VOLUME /cache
WORKDIR /opt/workspace
