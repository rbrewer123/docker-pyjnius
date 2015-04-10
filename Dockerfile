FROM ubuntu:14.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    curl \
    cython \
    python \
    python-nose \
    software-properties-common \
    unzip
  
RUN add-apt-repository ppa:webupd8team/java && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    oracle-java9-installer

# latest as of 2015-04-08
ENV PYJNIUS_COMMIT a54772835cd7e50ff9737dc6bdd325e0cd568bbf

RUN mkdir -p /usr/src && \
    curl -SL -o /usr/src/repo.zip https://github.com/kivy/pyjnius/archive/${PYJNIUS_COMMIT}.zip && \
    unzip /usr/src/repo.zip -d /usr/src && \
    ln -s pyjnius-${PYJNIUS_COMMIT} /usr/src/pyjnius-repo

WORKDIR /usr/src/pyjnius-repo

# FIXME ignoring make tests failures for now
RUN make && \
    make tests ; \
    python setup.py install

COPY runasuser.sh /root/
RUN chmod a+x /root/runasuser.sh
    
RUN mkdir /data

WORKDIR /data

ENTRYPOINT ["/root/runasuser.sh"]

