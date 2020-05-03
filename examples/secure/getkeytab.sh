#!/usr/bin/env bash
kubectl exec krb5-0 -- rm /tmp/keytab 1>&2 || true
kubectl exec krb5-0 -- kadmin -kt /tmp/admin.keytab -p admin/admin -q "addprinc -randkey $1" 1>&2
kubectl exec krb5-0 -- kadmin -kt /tmp/admin.keytab -p admin/admin -q "ktadd -k /tmp/keytab $1" 1>&2
kubectl exec krb5-0 -- cat /tmp/keytab | base64
