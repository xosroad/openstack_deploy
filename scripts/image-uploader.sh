#!/bin/bash

IMAGE_MAINDIR='/home/xosroad/overcloud_images'
OVERCLOUD_RC='/home/xosroad/overcloud-2rc'

cd $IMAGE_MAINDIR
for i in $(ls); do
    if [ -f $i ]; then
        continue
    fi
    cd $i
    for j in $(ls); do
        glance image-create --name $j --disk-format qcow2 --container-format bare --visibility public --file ${PWD}/$j --progress 
    done
    cd - &>/dev/null
done
