FROM ubuntu:22.04
MAINTAINER Per-Arne Arndersen <per@sysx.no>
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt-get update && apt-get install -y \
    aufs-tools \
    automake \
    python3 \
    python3-pip \
    build-essential \
    python3-dev \
    cmake \
    libjs-mathjax \
    curl \
    git \
 && rm -rf /var/lib/apt/lists/*


RUN pip3 install --upgrade pip

COPY requirements.txt /opt/requirements.txt
RUN /usr/bin/python3 -m pip install -r /opt/requirements.txt

# install a collection of extensions
RUN pip3 install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master && \
    jupyter contrib nbextension install --system --symlink

RUN pip3 install jupyter_nbextensions_configurator
RUN jupyter nbextensions_configurator enable
RUN pip3 install git+https://github.com/uclmr/egal.git
RUN jupyter nbextension install --py  egal
RUN jupyter nbextension enable --py egal
ADD run.sh /opt/run.sh
RUN chmod +x /opt/run.sh
CMD ["/bin/bash", "/opt/run.sh"]
