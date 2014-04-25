#!/bin/bash

set -e

time (

  # Make vagrant automatically go to /vagrant when we ssh in.
  echo "cd /vagrant" | sudo tee -a ~vagrant/.profile

  export DEBIAN_FRONTEND=noninteractive

  sudo apt-get install -y python-pip htop
  sudo pip install fig

  # FIG BUILD
  cd /vagrant && fig build

  echo VAGRANT IS READY.

)
