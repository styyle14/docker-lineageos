FROM ubuntu:latest

ARG username="builder"
ARG password="${username}"

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get clean && \
	apt-get update -y && \
	apt-get upgrade -y

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y \
		bc \
		bison \
		build-essential \
		flex \
		g++-multilib \
		gcc-multilib \
		git \
		gnupg \
		gperf \
		imagemagick \
		lib32ncurses5-dev \
		lib32readline6-dev \
		lib32z1-dev \
		libesd0-dev \
		liblz4-tool \
		libncurses5-dev \
		libsdl1.2-dev \
		libwxgtk3.0-dev \
		libxml2 \
		libxml2-utils \
		lzop \
		openjdk-8-jdk \
		pngcrush \
		schedtool \
		squashfs-tools \
		unzip \
		wget \
		xsltproc \
		zip \
		zlib1g-dev

RUN \
	wget 'https://dl.google.com/android/repository/platform-tools-latest-linux.zip' && \
	unzip platform-tools-latest-linux.zip && \
	cp platform-tools/adb platform-tools/fastboot /usr/bin && \
	rm -rf platform-tools/ && \
	wget https://storage.googleapis.com/git-repo-downloads/repo && \
	mv repo /usr/bin

RUN \
	apt-get remove -y \
		build-essential && \ 
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/* /var/cache/apt/*

RUN \
	useradd \
		--create-home \
		--groups \
			sudo \
		"${username}" && \
	echo "${username}:${password}" | chpasswd

USER "${username}"
VOLUME ["/home/${username}/android/system"]
WORKDIR "/home/${username}/android/system"
EXPOSE 80 443
CMD repo

