# # # compute-master-node
# FROM phusion/baseimage
FROM ocramz/docker-phusion-supervisor

# # tool versions


# # update TLS-related stuff and install dependencies
RUN apt-get update && \
    apt-get -qq install -y --no-install-recommends ca-certificates debian-keyring debian-archive-keyring && \
    apt-key update && \
    apt-get -qq update && \
    apt-get -qq install -y --no-install-recommends make bzip2 unzip wget curl \
                                                   libmunge-dev libmunge2 munge \
						   slurm-llnl && \
						   rm -rf /var/lib/apt/lists/*

# # # environment variables
ENV USER=mpirun \
    HOME=/home/${USER} \
    BIN_DIR=${HOME}/bin \
    SRC_DIR=${HOME}/src \
    TMP=${HOME}/tmp \
    CERTS_DIR=${HOME}/.certs \
    ETC=${HOME}/etc

# # # Create directories
RUN mkdir -p $BIN_DIR && \
    mkdir -p $SRC_DIR && \
    mkdir -p $TMP && \
    mkdir -p $ETC && \
    mkdir -p $CERTS_DIR && \
    mkdir -p $HOME/bin

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