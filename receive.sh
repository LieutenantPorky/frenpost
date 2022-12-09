#!/usr/bin/env sh

source ./settings.sh

keys=$(curl --silent $serverAdd/post_id)

for i in $keys; do
    echo ""
    echo "###############"
    echo "key: $i"
    message=$(curl --silent $serverAdd/$i | gpg -d --output - 2> $gpgverify)
    echo "$message"
    signed=$(grep "Good signature" $gpgverify)
    echo "#-------------#"
    echo "$signed"
    echo "#-------------#"
    echo ""
    rm $gpgverify
done
