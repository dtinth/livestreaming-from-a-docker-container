FROM hectormolinero/xubuntu:latest

RUN yes | unminimize

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get install -y \
      ffmpeg \
      build-essential \
      libx11-dev \
      libxtst-dev \
      libpng-dev \
      chromium-browser \
      fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
      neovim \
	&& rm -rf /var/lib/apt/lists/*

RUN (curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -) \
  && sudo apt-get install -y nodejs \
	&& rm -rf /var/lib/apt/lists/* \
  && npm i -g yarn

RUN ( true \
  && echo 'load-module module-null-sink sink_name=stream-sink sink_properties=device.description=stream-sink' \
  && echo 'load-module module-null-sink sink_name=voip-sink sink_properties=device.description=voip-sink' \
  && echo 'load-module module-remap-source source_name=voip-input source_properties=device.description=voip-input master=voip-sink.monitor' \
  && echo 'load-module module-combine-sink sink_name=apps-sink sink_properties=device.description=apps-sink slaves=stream-sink,xrdp-sink,voip-sink' \
  && echo 'load-module module-combine-sink sink_name=voip-output-sink sink_properties=device.description=voip-output-sink slaves=stream-sink,xrdp-sink' \
  && echo 'set-default-sink apps-sink' \
  ) >> /etc/xrdp/pulse/default.pa

RUN echo 'guest ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers