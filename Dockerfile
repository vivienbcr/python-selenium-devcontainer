FROM ubuntu:20.04

# Install dependencies
# COPY requirements.txt /pyselboilerplate/

COPY build/install.sh install.sh
COPY requirements.txt pyselboilerplate/requirements.txt
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN export DEBIAN_FRONTEND=noninteractive && export DEBCONF_NONINTERACTIVE_SEEN=true
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install gnupg2 apt-utils wget
RUN apt-key adv --fetch-keys "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xea6e302dc78cc4b087cfc3570ebea9b02842f111" \
    && echo 'deb http://ppa.launchpad.net/chromium-team/beta/ubuntu bionic main ' >> /etc/apt/sources.list.d/chromium-team-beta.list
RUN apt-get -o Dpkg::Options::="--force-overwrite" --no-install-recommends install -y \
        bash \
        curl \
        unzip \
        sudo \
        wget \
        nano \
        git \
        build-essential \
        clang \
        libssl-dev \
        libglib2.0-0 \
        libnss3 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        chromium-browser \
        python3-dev \
        python3 \
        python3-pip \
        && rm -rf /var/lib/apt/lists/* \
              /var/cache/apk/* \
              /usr/share/man \
              /tmp/*

RUN chmod +x ./install.sh && ./install.sh

RUN pip3 install autopep8 -r pyselboilerplate/requirements.txt --no-cache-dir

RUN useradd -u 1000 -U -m pydev \
    # && pip3 install autopep8 selenium \
    # && wget https://chromedriver.storage.googleapis.com/88.0.4324.27/chromedriver_linux64.zip \
    && mkdir -p /home/pydev/.vscode-server /home/pydev/.vscode-server-insiders /home/pydev/commandhistory\
    && echo "export PROMPT_COMMAND='history -a'" | tee -a /home/pydev/.bashrc \
    && echo "export HISTFILE=~/commandhistory/.bash_history" | tee -a /home/pydev/.bashrc \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ls -all /home/pydev/ \
    && chown pydev: -R /home/pydev/

USER pydev

# Empty the ENTRYPOINT to allow all commands
ENTRYPOINT []
