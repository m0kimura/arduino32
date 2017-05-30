FROM m0kimura/ubuntu-jdk

ARG user=${user:-docker}
ADD arduino-1.8.2-linux64.tar.xz /home/${user}
ADD arduino15 /home/${user}/.arduino15/
ADD starter.sh /home/${user}/starter.sh
RUN chown -R ${user}:${user} /home/${user} && \
    echo sketchbook.path=/home/${user}/Arduino >> /home/${user}/.arduino15/preferences.txt && \
    usermod -a -G dialout ${user} && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install pyserial && \
    rm get-pip.py

VOLUME /home/${user}
WORKDIR /home/${user}
USER ${user}
ENV HOME /home/${user}
CMD ./starter.sh

