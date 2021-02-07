#!/bin/sh
set -e

printf "&myIPAddress=%s&chatPort=%s&gamePort=%s" \
  "${ADDRESS}" "${LOBBY_PORT}" "${GAME_PORT}" > /qr/http/address.txt

(cd /qr/http && python -m http.server 2>&1) | sed -e 's/^/[http] /' >&2 &
(cd /qr/server && python -m QRServer -l -b 0.0.0.0 -p 3000 -q 3001)
