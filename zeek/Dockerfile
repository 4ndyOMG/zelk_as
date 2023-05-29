FROM zeek/zeek:latest
# To do: add version as a variable from .env
RUN apt update && apt install -y \
    --no-install-recommends git \
    curl \
    wget \
    jq \
    inotify-tools \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    && python3 -m pip install --upgrade --upgrade-strategy only-if-needed pip
###########
# zeek packages
###########
RUN python3 -m pip install "zkg" \
    && mkdir /.zkg
RUN yes | zkg install ja3 \
    && yes | zkg install bzar
##########
# suricata
##########
RUN apt update && apt install -y \
    --no-install-recommends git \
    suricata \
    suricata-update
##########
# elastic-agent
##########
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.5.3-linux-x86_64.tar.gz \
&& tar xzvf elastic-agent-8.5.3-linux-x86_64.tar.gz 
