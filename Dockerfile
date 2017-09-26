FROM m0kimura/ubuntu-jdk

ARG user=${user:-docker}
RUN apt-get update \


##  GET PIP
&&  apt-get install -y python \
&&  wget https://bootstrap.pypa.io/get-pip.py \
&&  chmod +x get-pip.py \
&&  ./get-pip.py \
&&  rm get-pip.py \
##


##  ARDUINO
&&  wget -q http://docker.kmrweb.net.s3-website-ap-northeast-1.amazonaws.com/arduino-1.8.2-linux64.tar.xz \
&&  tar Jxf arduino-1.8.2-linux64.tar.xz -C /home/${user} \
&&  rm arduino-1.8.2-linux64.tar.xz \
&&  wget -q http://docker.kmrweb.net.s3-website-ap-northeast-1.amazonaws.com/arduino15.tar.gz \
&&  tar -zxf arduino15.tar.gz -C /home/${user} \
&&  mv /home/${user}/arduino15 /home/${user}/.arduino15 \
&&  rm arduino15.tar.gz \
&&  echo sketchbook.path=/home/${user}/Arduino >> /home/${user}/.arduino15/preferences.txt \
&&  chown -R ${user}:${user} /home/${user} \
&&  usermod -a -G dialout ${user} \
##


&&  pip install pyserial \

&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*


##  USER
ENV HOME=/home/${user} USER=${user}
WORKDIR $HOME
USER $USER
##

ADD starter.sh /root/starter.sh
CMD /root/starter.sh

