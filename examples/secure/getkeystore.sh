#!/usr/bin/env bash
STATEDIR=".state/keystore"
mkdir -p "$STATEDIR"
CADIR=".state/ca"
NAME="$1"
DESCRIPTOR="$2"
STATEFILE="$STATEDIR/$NAME"
if [ ! -f "$STATEFILE" ]; then
   source "$DESCRIPTOR"
   PRIMARY_DOMAIN=ozone-om-0
   OTHER_DOMAINS=ozone-om-0.ozone.om
   certstrap --depot-path "$CADIR" request-cert --passphrase "" --domain $PRIMARY_DOMAIN,$OTHER_DOMAINS &1>2
   certstrap --depot-path "$CADIR" sign --CA ca $PRIMARY_DOMAIN &1>2
   openssl pkcs12 -export \
       -in $CADIR/$PRIMARY_DOMAIN.crt \
       -inkey $CADIR/$PRIMARY_DOMAIN.key \
       -out "$STATEFILE" \
       -name jetty \
       -CAfile "$CADIR/ca.crt" \
       -caname ca \
       -passout pass:Welcome1
   keytool -import \
       -keystore "$STATEFILE" \
       -alias trust \
       -storepass  Welcome1 \
       -file $CADIR/ca.crt \
       -trustcacerts  -noprompt
fi
echo "keystore $(cat "$STATEDIR/$NAME" | base64 -w 0)"
