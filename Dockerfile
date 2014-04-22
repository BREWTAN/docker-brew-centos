
INSTRUCTION qpid svn deploy

FROM insaneworks/centos

MAINTAINER  BREWTAN


###################
# yum install

RUN yum install -y vim unzip subversion supervisor openssh-server openssh-clients &&\
yum clean all

ENV LANG en_US.UTF-8

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -P "" -q \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -P "" -q \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config \
    && echo 'root:000000'|chpasswd

ADD supervisord.conf /etc/supervisord.conf
EXPOSE 22
CMD ["/usr/bin/supervisord"]
