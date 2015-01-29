FROM phusion/baseimage
MAINTAINER laurent@laurentroger.com
ENV DEBIAN_FRONTEND noninteractive

ADD apt.sources.list /etc/apt/apt.sources.list

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y erlang git

# Shut up policy-rc.d
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
# setup ssh
RUN echo root:erlang-koans | chpasswd
RUN mkdir -p /var/run/sshd
# Regenerate SSH host keys
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN ssh-keygen -A
## passwordless login for root
RUN mkdir -p /root/.ssh
RUN ssh-keygen -N '' -f /root/.ssh/id_dsa
RUN cat /root/.ssh/id_dsa.pub >> /root/.ssh/authorized_keys
RUN echo -n "localhost " > /root/.ssh/known_hosts
RUN cat /etc/ssh/ssh_host_rsa_key.pub >> /root/.ssh/known_hosts

## install erlang-koans
RUN git clone https://github.com/patrickgombert/erlang-koans /erlang-koans
RUN cd /erlang-koans && git checkout master

# expose ssh
EXPOSE 22/tcp

VOLUME ["/erlang-koans/src"]

CMD ["/sbin/my_init"]