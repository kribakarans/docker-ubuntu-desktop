#!/bin/bash

set -v
docker run -it --detach --name ubuntu-xfce -h docker-desktop -p 5901:5901 -p 6901:6901 -v $HOME/Public:/data ubuntu-xfce
