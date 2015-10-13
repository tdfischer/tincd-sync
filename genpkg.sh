#!/bin/bash

rm keys.tar.gz keys.sig
tar cfv keys.tar.gz $@
gpg -a -b keys.tar.gz
mv keys.tar.gz.asc keys.sig

echo "Generated keys.tar.gz and keys.sig."
