#!/bin/bash
#
##
  if [[ ! -e $HOME/Arduino/hardware/espressif ]]; then
    mkdir -p $HOME/Arduino/hardware/espressif
    cd $HOME/Arduino/hardware/espressif
    git clone https://github.com/espressif/arduino-esp32.git esp32
    cd esp32/tools/
    python get.py
  fi
##
  cd $HOME
  arduino-1.8.2/arduino
##

