# # # compute-master-node
FROM phusion/baseimage

# # tool versions
ENV CONSUL_VER 0.6.3

# # TLS-related
RUN apt-get update && \
    apt-get -qq install -y --no-install-recommends ca-certificates debian-keyring debian-archive-keyring && \
    apt-key update


# # Install tools
RUN apt-get -qq update && \
    apt-get -qq install -y --no-install-recommends make bzip2 unzip wget curl \
                                                   libmunge-dev libmunge2 munge \
						   slurm-llnl && \
						   rm -rf /var/lib/apt/lists/*


# # # Set up environment variables
ENV BIN_DIR $HOME/bin
ENV SRC_DIR $HOME/src
ENV TMP $HOME/tmp
# TLS
ENV CERTS_DIR $HOME/.certs
# Consul
ENV CONSULTMP $TMP/consul

ENV ETC $HOME/etc

# # # Create directories
RUN mkdir -p $BIN_DIR
RUN mkdir -p $SRC_DIR
RUN mkdir -p $TMP
RUN mkdir -p $ETC
# # TLS
RUN mkdir -p $CERTS_DIR
# # Consul
RUN mkdir -p $CONSULTMP
RUN mkdir -p $HOME/bin

RUN mkdir -p $ETC/consul.d

# # augment PATH
ENV PATH $BIN_DIR:$PATH



# # # ==== Consul


WORKDIR $TMP

RUN wget https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_linux_amd64.zip 
RUN unzip consul_${CONSUL_VER}_linux_amd64.zip -d $BIN_DIR
# # delete Consul zip to save space :
RUN rm consul_${CONSUL_VER}_linux_amd64.zip

RUN consul --version


# # test Consul (NB: stop with C-c)
# RUN consul agent -server -bootstrap -data-dir $CONSULTMP
# RUN curl localhost:8500/v1/catalog/nodes







# # # ==== MUNGE

# #create Munge key (not sure it's a good idea to do this during Docker build)
# RUN dd if=/dev/random bs=1 count=1024 >/etc/munge/munge.key

# # test MUNGE
# RUN /usr/sbin/munged




# # # ==== SLURM



WORKDIR $HOME



ADD bin/run-consul.sh ${BIN_DIR}
CMD ${BIN_DIR}/run-consul.sh



# # # clean local package archive
RUN apt-get clean