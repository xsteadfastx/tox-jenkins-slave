FROM ubuntu:trusty

RUN gpg --keyserver keyserver.ubuntu.com --recv-keys DB82666C \
 && gpg --export DB82666C | apt-key add -

RUN echo deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main >> /etc/apt/sources.list \
 && echo deb-src http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main >> /etc/apt/sources.list

RUN apt-get update \
 && apt-get install -y \
    git \
    openssh-server \
    openjdk-7-jre-headless \
    python-pip \
    python2.3 \
    python2.4 \
    python2.5 \
    python2.6 \
    python3.1 \
    python3.2 \
    python3.3 \
    python3.4 \
    python3.5 \
 && rm -rf /var/lib/apt/lists/*

RUN pip install tox

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
 && mkdir -p /var/run/sshd

RUN adduser --quiet jenkins \
 && echo "jenkins:jenkins" | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
