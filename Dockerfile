FROM centos:8

RUN dnf -y update && \
    dnf -y install 'dnf-command(config-manager)' && \
    dnf -y config-manager --set-enabled PowerTools && \
    dnf -y install epel-release

RUN dnf -y install gcc-c++ \
                   make \
                   cmake \
                   git \
                   python3-pip \
                   wget
RUN dnf -y install eigen3-devel \
                    patch \
                    tinyxml-devel \
                    tinyxml2-devel \
                    pcre-devel \
                    file \
                    python3-devel

WORKDIR /tmp
COPY asio-devel-1.10.8-10.el8.x86_64.rpm asio-devel-1.10.8-10.el8.x86_64.rpm
RUN dnf -y install asio-devel-1.10.8-10.el8.x86_64.rpm

RUN pip3 install --upgrade \
                   setuptools \
                   colcon-common-extensions \
                   vcstool \
                   rosdep
RUN pip3 install --upgrade \
                    argcomplete \
                    flake8 \
                    flake8-blind-except \
                    flake8-builtins \
                    flake8-class-newline \
                    flake8-comprehensions \
                    flake8-deprecated \
                    flake8-docstrings \
                    flake8-import-order \
                    flake8-quotes \
                    pytest-repeat \
                    pytest-rerunfailures \
                    pytest \
                    pytest-cov \
                    pytest-runner \
                    setuptools \
                    lark-parser

RUN mkdir -p /ros/src
WORKDIR /ros
COPY dashing-base.rosinstall .
RUN vcs import src < dashing-base.rosinstall
RUN colcon build
