#!/bin/bash

set -e

time (

  # Make vagrant automatically go to /vagrant when we ssh in.
  echo "cd /vagrant" | sudo tee -a ~vagrant/.profile

  export DEBIAN_FRONTEND=noninteractive

  sudo apt-get install -y python-pip htop
  sudo pip install fig

  # FIG BUILD
  cd /vagrant
  echo
  echo VERSIONS:
  echo
  fig run compiler bash -c 'clang --version; emcc --version'
  echo
  echo BUILD:
  fig run compiler bash -c 'cd /vagrant/build && ./build_lgpl.sh'
  echo

  echo VAGRANT IS READY.

)
