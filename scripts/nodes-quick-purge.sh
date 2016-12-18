#!/bin/bash

for i in $(ironic node-list | awk '{print $2}' | egrep -v "^$|^UUID"); do
    ironic node-delete $i
done
