ALIAS=jetty
openssl pkcs12 -export \
               -in out/$1.crt \
               -inkey out/$1.key \
               -out out/$1.p12 \
               -name $ALIAS \
               -CAfile $SSL_DIR/ca.crt \
               -caname ca \
               -passout pass:Welcome1

keytool -importkeystore \
        -deststorepass Welcome1 \
        -destkeypass Welcome1 \
        -destkeystore out/$1.keystore \
        -srckeystore out/$1.p12 \
        -srcstoretype PKCS12 \
        -srcstorepass Welcome1 \
        -alias $ALIAS \
        -deststoretype pkcs12
