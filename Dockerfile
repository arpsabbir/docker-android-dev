# Android development environment based on Ubuntu 14.04 LTS.
# version 0.0.1

# - https://services.gradle.org/distributions/gradle-2.0-bin.zip
# - http://dl.google.com/android/android-sdk_r23.0.2-linux.tgz
# - https://dl.google.com/android/ndk/android-ndk-r9d-linux-x86_64.tar.bz2

# Start with Ubuntu 14.04 LTS.
FROM phusion/baseimage

MAINTAINER Zaicheng Qi <vmlinz@gmail.com>

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

# First, install add-apt-repository and bzip2
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y install software-properties-common python-software-properties bzip2 unzip openssh-client git lib32stdc++6 lib32z1

# Add oracle-jdk7 to repositories
RUN add-apt-repository ppa:webupd8team/java

# Update apt
RUN apt-get update

# Install oracle-jdk7
RUN apt-get -y install oracle-java7-installer

# Install android sdk
RUN wget http://dl.google.com/android/android-sdk_r23.0.2-linux.tgz
RUN tar -xvzf android-sdk_r23.0.2-linux.tgz
RUN mv android-sdk-linux /usr/local/android-sdk
RUN rm android-sdk_r23.0.2-linux.tgz

# Install Android tools
RUN curl -3L -o /tmp/accept-licenses https://github.com/embarkmobile/android-sdk-installer/raw/version-2/accept-licenses
RUN chmod +x /tmp/accept-licenses
RUN /tmp/accept-licenses "/usr/local/android-sdk/tools/android update sdk --filter tools,platform-tools,build-tools-19.1.0,android-19,extra-google-google_play_services,extra-android-support,extra-android-m2repository,extra-google-analytics_sdk_v2 --no-ui --force -a" "android-sdk-license-5be876d5|android-sdk-preview-license-52d11cd2"

# Install Android NDK
RUN wget https://dl.google.com/android/ndk/android-ndk-r9d-linux-x86_64.tar.bz2
RUN tar -xvjf android-ndk-r9d-linux-x86_64.tar.bz2
RUN mv android-ndk-r9d /usr/local/android-ndk
RUN rm android-ndk-r9d-linux-x86_64.tar.bz2

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-2.0-bin.zip
RUN unzip gradle-2.0-bin.zip
RUN mv gradle-2.0 /usr/local/gradle
RUN rm gradle-2.0-bin.zip

# Environment variables
ENV ANDROID_HOME /usr/local/android-sdk
ENV ANDROID_SDK_HOME $ANDROID_HOME
ENV ANDROID_NDK_HOME /usr/local/android-ndk
ENV GRADLE_HOME /usr/local/gradle
ENV PATH $PATH:$ANDROID_SDK_HOME/tools
ENV PATH $PATH:$ANDROID_SDK_HOME/platform-tools
ENV PATH $PATH:$ANDROID_NDK_HOME
ENV PATH $PATH:$GRADLE_HOME/bin

# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Clean up
RUN apt-get clean
RUN rm /tmp/accept-licenses
