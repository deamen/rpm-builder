FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

# Install rpm-build package
RUN microdnf update -y && \
    microdnf install -y rpm-build

# Setup the rpmbuild directory structure
RUN mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Set working directory
WORKDIR /root/rpmbuild

CMD ["/bin/bash"]

