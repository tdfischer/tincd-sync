# tincd network sync tools

Two small scripts that can help keep a tincd network in sync.

```$ genpkg.sh [host-config] [host-config] ...```

Pass it a list of files that will get combined into a signed package. A signed
package is composed of a keys.tar.gz and keys.sig. Copy them to some common base
URL, such as https://example.com/tincd-configs/

```$ sync.sh <url> <key-id>```

This will download $url/keys.tar.gz and $url/keys.sig, verify the correct GPG
signature, and extract to the current directory. You likely want to run this as:

```cd /etc/tinc/some-network/hosts && sync.sh ...```
