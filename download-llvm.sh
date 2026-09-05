#!/bin/sh
set -x -e

BASE=llvm-23.1.0-x86_64
DIR=

cat <<EOF > CHECKSUMS
a5ff3fe2e663195abe000668efcbec13c2d25c239f5a20b6628991629091caad  ${BASE}.tar.gz
EOF

curl -C - -O "https://mirrors.kernel.org/pub/tools/llvm/files/${DIR}${BASE}.tar.gz"
sha256sum -c CHECKSUMS
rm -rf "${BASE}" llvm
tar xf "${BASE}.tar.gz"
mkdir -p /opt
mv "${BASE}" /opt/llvm
rm -f "${BASE}.tar.gz" CHECKSUMS
