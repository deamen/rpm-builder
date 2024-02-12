#!/bin/bash

set -e

# Define the container name
export container=$(buildah from quay.io/deamen/rpm-builder-ubi)

# Define the spec file name
spec_file="msttcorefonts-2.5-2.spec"


# Install additional dependencies required for msttcorefont
buildah run $container -- microdnf install -y ttmkfdir wget

# Download and install cabextract
buildah run $container -- wget https://www.cabextract.org.uk/cabextract-1.11-1.x86_64.rpm
buildah run $container -- rpm -i cabextract-1.11-1.x86_64.rpm

# Copy the spec file into the container
buildah copy $container msttcorefonts/$spec_file /root/rpmbuild/SPECS/

# Build the RPM (this might need adjustments depending on your spec file)
buildah run $container -- rpmbuild -ba /root/rpmbuild/SPECS/$spec_file


copy_script="copy_artifacts.sh"
cat << 'EOF' >> $copy_script
#!/bin/sh
mnt=$(buildah mount $container)
cp $mnt/$1 ./$2
buildah umount $container
EOF
chmod a+x $copy_script
buildah unshare ./$copy_script root/rpmbuild/RPMS/noarch/*.rpm ./out/
rm ./$copy_script
buildah rm $container


echo "RPM build complete and copied to localhost."

