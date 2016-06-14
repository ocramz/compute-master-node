FROM phusion/baseimage

# # tool versions
ENV CONSUL_VER 0.6.3

RUN apt-get update

# # TLS-related
RUN apt-get -qq install -y --no-install-recommends ca-certificates debian-keyring debian-archive-keyring
RUN apt-key update
RUN apt-get -qq update

# # Install tools
RUN apt-get -qq install -y --no-install-recommends make bzip2 unzip wget curl


# # Set up environment variables
ENV LOCAL_DIR $HOME/.local
ENV BIN_DIR $HOME/.local/bin
ENV SRC_DIR $HOME/src
ENV TMP $HOME/tmp
ENV CONSULTMP $TMP/consul
ENV ETC $HOME/etc

# # Create directories
RUN mkdir -p $LOCAL_DIR
RUN mkdir -p $BIN_DIR
RUN mkdir -p $SRC_DIR
RUN mkdir -p $TMP
RUN mkdir -p $ETC

RUN mkdir -p $CONSULTMP
RUN mkdir -p $ETC/consul.d

# # augment PATH
ENV PATH $BIN_DIR:$PATH



# # # ==== Consul



RUN travis_retry wget https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_linux_amd64.zip 
RUN unzip consul_${CONSUL_VER}_linux_amd64.zip -d $BIN_DIR

RUN consul --version