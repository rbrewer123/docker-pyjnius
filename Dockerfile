FROM ubuntu:14.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    curl \
    cython \
    python \
    python-nose \
    software-properties-common
  
RUN add-apt-repository ppa:webupd8team/java && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    oracle-java9-installer


RUN mkdir -p /usr/src && \
    curl -SL https://github.com/kivy/pyjnius/archive/1.0.3.tar.gz | \
    tar xzC /usr/src

WORKDIR /usr/src/pyjnius-1.0.3

RUN make && \
    make tests && \
    python setup.py install

COPY runasuser.sh /root/
RUN chmod a+x /root/runasuser.sh
    
RUN mkdir /data

WORKDIR /data

ENTRYPOINT ["/root/runasuser.sh"]

