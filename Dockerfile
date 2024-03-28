FROM jlesage/baseimage-gui:ubuntu-22.04-v4

ENV APP_NAME="P3R OpenRGB"
ENV KEEP_APP_RUNNING=1
ENV ENABLE_CJK_FONT=1
ENV LANG=en_US.UTF-8

WORKDIR /usr/src/openrgb

COPY OpenRGB .
COPY startapp.sh /startapp.sh
COPY default.orp /config/xdg/config/OpenRGB/default.orp
COPY 60-openrgb.rules /usr/lib/udev/rules.d/60-openrgb.rules

RUN chmod +x /usr/src/openrgb/OpenRGB
RUN apt-get update \
	&& apt-get -y install \
	libusb-1.0-0 \
	libqt5widgets5 \
	libqt5core5a \
	libqt5gui5 \
	usbutils \
	i2c-tools \
	locales \
	libhidapi-dev \
	libmbedx509-1 \
	libmbedtls-dev \
	&& locale-gen en_US.UTF-8
	
RUN sed -i '/messagebus/d' /var/lib/dpkg/statoverride && \
    ln -s /lib/x86_64-linux-gnu/libmbedx509.so.1 /lib/x86_64-linux-gnu/libmbedx509.so.0 && \
    ln -s /lib/x86_64-linux-gnu/libmbedtls.so.14 /lib/x86_64-linux-gnu/libmbedtls.so.12 && \
    ln -s /lib/x86_64-linux-gnu/libmbedcrypto.so.7 /lib/x86_64-linux-gnu/libmbedcrypto.so.3 && \
    chmod +x /startapp.sh
