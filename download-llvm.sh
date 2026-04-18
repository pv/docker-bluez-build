#!/bin/sh
set -x -e

BASE=llvm-23.0.0-a955b3cabab66bba586fdd14f56ab251c50dfc05-20260404-111258-x86_64
DIR=prerelease/

cat <<EOF > CHECKSUMS
f15cecd781141e9ba1baebe3ac9f9bf8d186dc0b024bc46360715e61c117cf36  ${BASE}.tar.gz
EOF

curl -C - -O "https://mirrors.kernel.org/pub/tools/llvm/files/${DIR}${BASE}.tar.gz"
sha256sum -c CHECKSUMS
rm -rf "${BASE}" llvm
tar xf "${BASE}.tar.gz"
mkdir -p /opt
mv "${BASE}" /opt/llvm
rm -f "${BASE}.tar.gz" CHECKSUMS
