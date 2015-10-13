#!/bin/bash

URL=$1;

function usage() {
  echo "Usage: $0 <url> <keyid>"
}

echo $#

if [ $# -ne 2 ]; then
  usage
  exit 1
fi

URL=$1
OUTPUT=`pwd`
KEYID=$2

TMPDIR=$(mktemp -d)

curl -k $URL/keys.tar.gz > $TMPDIR/keys.tar.gz
curl -k $URL/keys.sig > $TMPDIR/keys.sig
PKG_KEYID=$(gpg --verify $TMPDIR/keys.sig $TMPDIR/keys.tar.gz 2>&1 | head -n 1 | awk -F 'ID ' '{print $2}')
if [ $? -eq 0 ];then
  if [ "$PKG_KEYID" == "$KEYID" ]; then
    tar xfv $TMPDIR/keys.tar.gz -C $OUTPUT
  else
    echo "WARNING: Not signed by $KEYID!"
  fi
else
  echo "keys.tar.gz signature could not be verified."
fi
