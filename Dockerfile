FROM hectormolinero/xubuntu:latest

RUN yes | unminimize

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get install -y \
	  autoconf \
      ffmpeg \
      build-essential \
      libx11-dev \
      libxtst-dev \
      libpng-dev \
      chromium-browser \
      neovim \
	&& rm -rf /var/lib/apt/lists/*

RUN ( \
    echo 'load-module module-null-sink sink_name=stream-sink' \
    && echo 'update-sink-proplist stream-sink device.description=stream-sink' \
    && echo 'load-module module-combine-sink sink_name=combined-sink slaves=stream-sink,xrdp-sink' \
    && echo 'set-default-sink combined-sink' \
  ) >> /etc/xrdp/pulse/default.pa
  
RUN (curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -) \
  && sudo apt-get install -y nodejs \
	&& rm -rf /var/lib/apt/lists/* \
  && npm i -g yarn

RUN echo 'guest ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers