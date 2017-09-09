#FROM openjdk:8-jdk
FROM cern/slc6-base

COPY install_bare_essentials.sh /install_bare_essentials.sh
RUN sh /install_bare_essentials.sh
#RUN apt-get update
#RUN apt-get install -y build-essential curl git ruby vim
RUN useradd --create-home -s /bin/bash user
WORKDIR /home/user
USER user

COPY test_linuxbrew.sh /home/user/test_linuxbrew.sh
CMD ["./test_linuxbrew.sh"]
