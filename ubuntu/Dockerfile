FROM scratch
MAINTAINER Guojian Zhou "joe_zgj@163.com"
ENV REFRESHED_AT 2018-08-01

ADD ubuntu-base-16.04.4-base-amd64.tar.gz /

RUN apt update && apt install apt-utils iputils-ping net-tools openssh-server vim sudo git -y 

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/joe && \
    echo "joe:x:${uid}:${gid}:Abc,,,:/home/joe:/bin/bash" >> /etc/passwd && \
    echo "joe:x:${uid}:" >> /etc/group && \
    echo "joe ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/joe && \
    chmod 0440 /etc/sudoers.d/joe && \
    chown ${uid}:${gid} -R /home/joe
 
USER joe
ENV HOME /home/joe
WORKDIR $HOME
CMD /bin/bash

