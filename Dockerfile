FROM centos:7
MAINTAINER Ivan Tyshchenko "iv.tihon@gmail.com"
RUN yum makecache \
  && yum install -y epel-release \
  && yum update -y \
  && yum install -y automake bzip2 gcc-c++ patch ncurses-devel openssl-devel \
  libxml2-devel libcurl-devel libogg-devel libvorbis-devel speex-devel \
  spandsp-devel net-snmp-devel iksemel-devel newt-devel popt-devel \
  libtool-ltdl-devel lua-devel sqlite-devel radiusclient-ng-devel \
  postgresql-devel libresample-devel neon-devel libical-devel openldap-devel \
  gsm-devel libedit-devel libuuid-devel libsrtp-devel pjproject-devel \
  subversion git libxslt-devel python-devel wget tar xz jansson-devel \
  xmlstarlet gmime-devel
WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/asterisk-certified-13.13-current.tar.gz \
  && tar -zxvf asterisk-certified-13.13-current.tar.gz
WORKDIR /usr/src/asterisk-certified-13.13-cert2/
RUN sh contrib/scripts/get_mp3_source.sh
RUN ./configure --with-pjproject-bundled CFLAGS='-g -O2 -mtune=native' \
  --libdir=/usr/lib64 --without-dahdi --without-gsm --without-gmime \
  --without-resample --without-unixodbc --without-portaudio --without-misdn \
  --without-asound --without-bluetooth --without-mysqlclient --without-oss \
  --without-suppserv --without-tds --without-vpb --without-x11
COPY menuselect.makeopts /usr/src/asterisk-certified-13.13-cert2/menuselect.makeopts
RUN make && make install
WORKDIR /tmp/
RUN yum remove -y automake bzip2 gcc-c++ patch ncurses-devel openssl-devel \
  libxml2-devel libcurl-devel libogg-devel libvorbis-devel speex-devel \
  spandsp-devel net-snmp-devel iksemel-devel newt-devel popt-devel \
  libtool-ltdl-devel lua-devel sqlite-devel radiusclient-ng-devel \
  postgresql-devel libresample-devel neon-devel libical-devel openldap-devel \
  gsm-devel libedit-devel libuuid-devel libsrtp-devel pjproject-devel \
  subversion git libxslt-devel python-devel wget jansson-devel \
  gmime-devel \
  && yum clean all -y \
  && rm -rf /usr/src/*
CMD ["/usr/sbin/asterisk", "-f"]
