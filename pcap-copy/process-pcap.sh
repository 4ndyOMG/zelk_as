#!/bin/bash
while true
do
inotifywait -r -e create,modify /opt/pcap && \
for file in /opt/pcap/*.pcap;
do zeek -r /opt/pcap/$file Log::default_logdir=/usr/local/zeek/logs/pcap/ LogAscii::use_json=T && \
    suricata -r /opt/pcap/$file -l /var/log/suricata/pcap/ && \
    rm /opt/pcap/$file;
done
done
