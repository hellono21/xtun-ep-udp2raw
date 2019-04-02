#!/bin/sh -e
check_ip() {
  IP_REGEX='^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$'
  printf '%s' "$1" | tr -d '\n' | grep -Eq "$IP_REGEX"
}
check_ip "$TUNNEL_HOST" || TUNNEL_HOST=$(dig -t A -4 $TUNNEL_HOST +short)

cat > /opt/udp2raw/udp2raw.conf <<EOF

-s
# You can add comments like this
# Comments MUST occupy an entire line
# Or they will not work as expected
# Listen address
-l 0.0.0.0:443
# Remote address
-r $TUNNEL_HOST:$TUNNEL_PORT
-k $XTUN_PSK
--cipher-mode xor
-a
--raw-mode faketcp
EOF

/opt/udp2raw/udp2raw_amd64 --conf-file /opt/udp2raw/udp2raw.conf
