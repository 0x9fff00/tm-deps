FROM debian/eol:wheezy

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
        autoconf \
        build-essential \
        curl \
        libc-ares2 \
        libcap2 \
        libgcrypt11 \
        libgl1-mesa-swx11 \
        libglu1-mesa \
        libglu1-mesa-dev \
        libgnutls26 \
        libgpg-error0 \
        libgtk2.0-0 \
        libgtk2.0-dev \
        libjpeg8 \
        libjpeg8-dev \
        libsqlite3-0 \
        libssh2-1 \
        libssl1.0.0 \
        libtasn1-3 \
        libtiff5 \
        libtiff5-dev \
        mesa-common-dev \
        pkg-config \
        && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /build && \
    cd /build && \
    curl -Lo config.guess https://git.savannah.gnu.org/cgit/config.git/plain/config.guess?id=a2287c3041a3f2a204eb942e09c015eab00dc7dd && \
    chmod +x config.guess && \
    \
    curl -LO https://archives.boost.io/release/1.51.0/source/boost_1_51_0.tar.bz2 && \
    tar --no-same-owner -xf boost_1_51_0.tar.bz2 && \
    cd boost_1_51_0 && \
    ./bootstrap.sh --with-libraries=chrono,system,thread && \
    ./b2 install && \
    cd .. && \
    \
    curl -LO https://github.com/wxWidgets/wxWidgets/releases/download/v2.9.4/wxWidgets-2.9.4.tar.bz2 && \
    tar --no-same-owner -xf wxWidgets-2.9.4.tar.bz2 && \
    cd wxWidgets-2.9.4 && \
    cp -a /build/config.guess . && \
    ./configure && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    \
    curl -LO https://downloads.sourceforge.net/project/wxcode/Components/wxFreeChart/freechart-1.6.tar.gz && \
    tar --no-same-owner -xf freechart-1.6.tar.gz && \
    cd freechart && \
    cp -a /build/config.guess build/ && \
    ./configure && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    \
    curl -Lo wxsqlite3-3.5.9.tar.gz https://github.com/utelle/wxsqlite3/archive/refs/tags/v3.5.9.tar.gz && \
    tar --no-same-owner -xf wxsqlite3-3.5.9.tar.gz && \
    cd wxsqlite3-3.5.9 && \
    autoreconf && \
    ./configure && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    \
    cd / && \
    rm -rf /build && \
    apt-get -y autoremove --purge \
        autoconf \
        build-essential \
        libglu1-mesa-dev \
        libgtk2.0-dev \
        libjpeg8-dev \
        libtiff5-dev \
        mesa-common-dev \
        pkg-config \
        && \
    apt-get -y autoremove --purge
