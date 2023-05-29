#!/bin/bash
while true
do
inotifywait -r -e create,modify /opt/pcap && \
for file in /opt/pcap/*.pcap;
do echo "Processing $file with zeek" && \
    zeek -r $file Log::default_logdir=/usr/local/zeek/logs/pcap/ LogAscii::use_json=T && \
    echo "Processing $file with suricata" && \
    suricata -r $file -l /var/log/suricata/pcap/ && \
    echo "Leaving slips to remove $file from pcap dir";
done
done
