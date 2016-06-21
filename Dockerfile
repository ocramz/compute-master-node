# # # compute-master-node
# FROM phusion/baseimage
FROM ocramz/docker-phusion-supervisor

# # tool versions


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

ENV ETC $HOME/etc

# # # Create directories
RUN mkdir -p $BIN_DIR
RUN mkdir -p $SRC_DIR
RUN mkdir -p $TMP
RUN mkdir -p $ETC
# # TLS
RUN mkdir -p $CERTS_DIR

RUN mkdir -p $HOME/bin

# # augment PATH
ENV PATH $BIN_DIR:$PATH











# # # ==== MUNGE

# #create Munge key (not sure it's a good idea to do this during Docker build)
# RUN dd if=/dev/random bs=1 count=1024 >/etc/munge/munge.key

# # test MUNGE
# RUN /usr/sbin/munged




# # # ==== SLURM



WORKDIR $HOME







# # # clean local package archive
RUN apt-get clean