FROM centos:8

RUN dnf -y update && dnf -y install rpm-build redhat-rpm-config autoconf automake boost-devel gcc gcc-c++ openssl-devel perl-generators make

RUN useradd -ms /bin/bash builder

USER builder
RUN mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
RUN echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros
