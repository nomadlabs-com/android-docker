[![Build Status](https://travis-ci.org/nomadlabs-com/android-docker.svg?branch=master)](https://travis-ci.org/nomadlabs-com/android-docker)

# Requirements

This image relies on the Android plugin's _auto-download missing packages_ feature, which requires

* Android Plugin for Gradle >= 2.2.0
* `android.build.sdkDownload=true` - It is `true` by default

## Usage

### Creating encrypted build secrets

**GnuPG 2.0**

    gpg2 --symmetric --batch --passphrase <passphrase> --output "<filename>.gpg" "<filename>"

**GnuPG 1.4**

    gpg --symmetric --passphrase <passphrase> --output "<filename>.gpg" "<filename>"

> _Note_: Generate a long, strong passphrase using a random generator

### CI

Make sure you set the encryption passphrase for your secrets in the `BUILD_SECRETS_PASSPHRASE` environment variable

**.gitlab-ci.yml**

    image: nomadlabs/android

    before_script:
      - mkdir -p "$ANDROID_HOME" && mv "$ANDROID_SDK_LICENSES" "$ANDROID_HOME"
      - decrypt secrets.tar.gpg another_secret.txt.gpg
      - tar -xf secrets.tar

    after_script:
      - tar -tf secrets.tar | xargs rm -r
      - rm secrets.tar
      - rm another_secret.txt.gpg

    assemble:
      stage: build
      script:
        - ./gradlew assemble
    
    check:
      stage: test
      script:
        - ./gradlew test

    publish:
      stage: deploy
      only:
        - master
      script:
        - ./gradlew publishApkRelease

### Local

From your project directory run:

    docker run -v "$(pwd):/opt/workspace" --rm -it /bin/sh -c "./gradle build"

or to use/test your encrypted build secrets

    docker run -e "BUILD_SECRETS_PASSPHRASE=<optional>" -v "$(pwd):/opt/workspace" --rm -it /bin/sh -c "decrypt secrets.tar.gpg && tar xf secrets.tar && ./gradle build"

