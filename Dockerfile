FROM alpine:edge

RUN apk add --no-cache \
    bash iptables \
    tcpdump wget curl bind-tools \
 && mv /usr/sbin/tcpdump /usr/bin/tcpdump \
 && ln -s /usr/bin/tcpdump /usr/sbin/tcpdump

COPY rootfs.tar /
RUN tar xf rootfs.tar -C /

EXPOSE 443/tcp

#ENTRYPOINT [ "/init" ]
CMD ["/opt/udp2raw/entry.sh"]
