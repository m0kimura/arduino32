#!/bin/bash
cmd=$1
project=${PWD##*/}


##  FX UTILITY
  if [[ ${cmd} = "push" ]]; then
    dex push
    exit
  elif [[ ${cmd} = "stop" ]]; then
    docker stop fx-${project}
    exit
  elif [[ ${cmd} = "login" ]]; then
    docker exec -it fx-${project} /bin/bash
    exit
  elif [[ ${cmd} = "export" ]]; then
    echo Export Container fx-${project} to local/fx-${project}.tar
    docker export fx-${project} -o ../local/fx-${project}.tar
    exit
  elif [[ ${cmd} = "save" ]]; then
    echo Save Image ${project} to local/${project}.tar
    docker save ${project} -o ../local/${project}.tar
    exit
  fi
##
##
  if [[ $DOCKER_DRIVE = "$null" ]]; then
    DOCKER_DRIVE=$HOME
  fi
  if [[ $1 = "run" ]]; then
    xhost +local:user
    docker rm fx-${project}
    docker run -d --name fx-${project} \
      --device=/dev/ttyUSB0 \
      -e DISPLAY=$DISPLAY \
      -e XMODIFIERS=$XMODIFIERS \
      -e XIMPROGRAM=$XIMPROGRAM \
      -e GTK_IM_MODULE=$GTK_IM_MODULE \
      -e QT_IM_MODULE=$QT_IM_MODULE \
      -e LC_TYPE=ja_JP.UTF-8 \
      -e TERM=xterm \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v fx-${project}/home/docker \
      -v $DOCKER_DRIVE/Arduino:/home/docker/Arduino \
      m0kimura/${project}
  else
    xhost +local:user
    docker start fx-${project}
  fi
##
