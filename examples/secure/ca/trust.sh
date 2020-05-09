

openssl pkcs12 -export -nokeys -in out/ca.crt -out truststore.keystore

#keytool -import -file cert.pem -alias trust -keystore keystore
