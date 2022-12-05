#!/usr/bin/env sh

source ./settings.sh

keys=$(curl $serverAdd/post_id)

for i in $keys; do
    echo ""
    echo ""
    echo "###############"
    echo "key: $i"
    curl $serverAdd/$i | gpg -d
done
