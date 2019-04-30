FROM ubuntu:trusty

COPY setupBasics.sh /setupBasics.sh
RUN sh /setupBasics.sh

RUN useradd -m -s /bin/bash gromit

WORKDIR /home/gromit
USER gromit

COPY keepawake /home/gromit/keepawake
COPY installLinuxBrew.sh /home/gromit/installLinuxBrew.sh
RUN sh ./installLinuxBrew.sh

CMD ["echo", "Good news everyone!"]
