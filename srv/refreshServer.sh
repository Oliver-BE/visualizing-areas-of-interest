#!/bin/bash

cd /srv/shinyapps/

#find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
ls | xargs -I{} sudo git -C {} reset --hard HEAD
ls | xargs -I{} sudo git -C {} pull
