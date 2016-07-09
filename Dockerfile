# # # compute-master-node
# FROM phusion/baseimage
FROM ocramz/docker-phusion-supervisor


ENV USER mpirun

# ------------------------------------------------------------
# Add an 'mpirun' user
# ------------------------------------------------------------

RUN adduser --disabled-password --gecos "" ${USER} && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}

# # # environment variables misc.
ENV HOME=/home/${USER} \
    BIN_DIR=${HOME}/bin \
    SRC_DIR=${HOME}/src \
    TMP=${HOME}/tmp \
    SSHDIR=${HOME}/.ssh/ \
    ETC=${HOME}/etc

# # # Create directories
RUN mkdir -p $BIN_DIR && \
    mkdir -p $SRC_DIR && \
    mkdir -p $TMP && \
    mkdir -p $ETC && \
    mkdir -p $SSHDIR && \
    mkdir -p $HOME/bin 



# # update TLS-related stuff and install dependencies
RUN apt-get update && \
    apt-get -qq install -y --no-install-recommends ca-certificates debian-keyring debian-archive-keyring && \
    apt-key update && \
    apt-get -qq update && \
    apt-get -qq install -y --no-install-recommends make bzip2 unzip wget curl \
                                                   openssh-server \
                                                   libmunge-dev libmunge2 munge \
						   slurm-llnl && \
						   rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# SSH
# ------------------------------------------------------------

RUN echo 'root:${USER}' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked oout after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd



# # # COPY SSH KEYS :

# # # 





RUN chmod -R 600 ${SSHDIR}* && \
    chown -R ${USER}:${USER} ${SSHDIR}





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