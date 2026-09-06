FROM ubuntu:26.04
LABEL org.opencontainers.image.source="https://github.com/pv/bluez-ci-image"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get install --no-install-recommends -y \
		autoconf \
		automake \
		autotools-dev \
		bc \
		bear \
		bison \
		black \
		build-essential \
		ca-certificates \
		ccache \
		chrony \
		clang-tools \
		cmake \
		cppcheck \
		curl \
		dbus-daemon \
		dkms \
		fakeroot \
		flex \
		gdb \
		git \
		git-core \
		gitlint \
		libasound2-dev \
		libdbus-1-dev \
		libdw-dev \
		libelf-dev \
		libglib2.0-dev \
		libiberty-dev \
		libical-dev \
		libjson-c-dev \
		libncurses-dev \
		libpci-dev \
		libreadline-dev \
		libsbc-dev \
		libspeexdsp-dev \
		libsqlite3-dev \
		libssl-dev \
		libsystemd-dev \
		libtool \
		libudev-dev \
		libxml2-dev \
		openssl \
		patch \
		pkg-config \
		python3-docutils \
		python3-pygments \
		python3 \
		python3-pip \
		python3-docutils \
		python3-pygments \
		python3-git \
		python3-junitparser \
		python3-github \
		python3-requests \
		python3-ply \
		python3-dbus \
		python3-pytest \
		python3-gi \
		python3-pexpect \
		python3-psutil \
		python3-pytest-xdist \
		qemu-system-x86 \
		systemd \
		systemd-dev \
		udev \
		valgrind \
		wget \
		xxd && \
	rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y locales

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN wget --no-verbose --no-check-certificate \
	https://raw.githubusercontent.com/torvalds/linux/master/scripts/checkpatch.pl -P /usr/bin/ && \
	chmod +x /usr/bin/checkpatch.pl

RUN wget --no-verbose --no-check-certificate \
	https://raw.githubusercontent.com/torvalds/linux/master/scripts/spelling.txt -P /usr/bin/ && \
	touch /usr/bin/const_structs.checkpatch

# Install Sparse tool
RUN git clone --depth 1 --revision=37156835e3d725b6d750f000be33ba3814bb2310 \
	https://git.kernel.org/pub/scm/devel/sparse/sparse.git /sparse && \
	cd /sparse && make && make PREFIX=/usr install && rm -rf /sparse

# Install smatch tool
RUN git clone --depth 1 --revision=5e13a0ee549b29edc4fd5b92579a49acf9194b63 \
	https://repo.or.cz/smatch.git /smatch && \
	cd /smatch && make

# Install pytest-bluezenv
RUN python3 -mpip install --break-system-packages pytest-bluezenv==0.1.9

# Install clang
COPY download-llvm.sh /
RUN /download-llvm.sh
