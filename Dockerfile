FROM alpine:edge

RUN apk add --no-cache \
    bash iptables \
    tcpdump wget curl bind-tools \
 && mv /usr/sbin/tcpdump /usr/bin/tcpdump \
 && ln -s /usr/bin/tcpdump /usr/sbin/tcpdump

COPY rootfs /

EXPOSE 443/tcp

#ENTRYPOINT [ "/init" ]
CMD ["/opt/udp2raw/entry.sh"]
