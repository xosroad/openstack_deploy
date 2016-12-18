#!/bin/bash

RANGE_START=$1
RANGE_END=$2
NODE_ROLE=$3

if [ "q${RANGE_START}" == "q" -o "q${RANGE_END}" == "q" -o "q${NODE_ROLE}" == "q" -o ${RANGE_START} -gt ${RANGE_END} ]; then
    echo "
    Usage:

    COMMAND RANGE_START RANGE_END NODE_ROLE

    ============================

    COMMAND:      This command
    RANGE_START:  Serial number of first node
    RANGE_END:    Serial number of the last node
    NODE_ROLE:    Single value within:
                    * control
                    * compute
                    * ceph-storage
                    * baremetal
"
fi

#PREFIX=$NODE_ROLE
#if [ "q$PREFIX" -eq "qcontrol" ]; then
#    PREFIX=controller
#elif [ "q$PREFIX" -eq "qceph-storage" ]; then
#    PREFIX=cephstorage
#fi
for ((i=${RANGE_START},j=0;i<=${RANGE_END};i++)); do
    #ironic node-update $(ironic node-list | awk '{print $2}' | egrep -v "^$|^UUID" | sed -n ${i}p) add properties/capabilities="node:${PREFIX}-${j},profile:${NODE_ROLE},boot_option:local"
    ironic node-update $(ironic node-list | awk '{print $2}' | egrep -v "^$|^UUID" | sed -n ${i}p) add properties/capabilities="profile:${NODE_ROLE},boot_option:local"
    j=$(echo $j + 1 | bc)
done
