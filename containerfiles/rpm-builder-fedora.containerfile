FROM registry.fedoraproject.org/fedora:39

# Install rpm-build package
RUN dnf --disablerepo=fedora-cisco-openh264 update -y --setopt=install_weak_deps=False && \
    dnf --disablerepo=fedora-cisco-openh264 install -y rpm-build --setopt=install_weak_deps=False

# Setup the rpmbuild directory structure
RUN mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Set working directory
WORKDIR /root/rpmbuild

CMD ["/bin/bash"]

