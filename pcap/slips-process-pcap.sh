#!/bin/bash
./webinterface.sh &
while true
do
inotifywait -r -e create,modify /opt/pcap && \
for file in /opt/pcap/*.pcap;
do echo "Processing $file with slips" && \
    ./slips.py -c config/slips.conf -e 1 -f $file ; \
    echo "slips processing command complete (I didn't say succesfully...)" && \
    echo "Removing $file from pcap dir" && \
    rm $file;
done
done
