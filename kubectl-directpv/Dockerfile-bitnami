FROM bitnami/kubectl:latest

USER root
RUN install_packages curl gawk

# Download DirectPV plugin
RUN curl -fLo /usr/local/bin/kubectl-directpv https://github.com/minio/directpv/releases/download/v4.1.5/kubectl-directpv_4.1.5_linux_amd64 && \
    chmod a+x /usr/local/bin/kubectl-directpv

ENV PATH="/usr/local/bin:${PATH}"

# Add your directpv-discovery script
#COPY docker/directpv-discovery/directpv-discovery.sh /usr/local/bin/directpv-discovery.sh
COPY directpv-discovery.sh /usr/local/bin/directpv-discovery.sh
RUN chmod +x /usr/local/bin/directpv-discovery.sh

WORKDIR /tmp

# Let CMD be overridable so you can run either kubectl or your script
CMD ["kubectl"]

