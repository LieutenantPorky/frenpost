#!/usr/bin/env sh

source ./settings.sh
printed_keys=""

while true; do
keys=$(curl --silent $serverAdd/post_id)

    for i in $keys; do
        if echo "$printed_keys" | grep -q "$i"; then
           continue
        fi
        printed_keys="$i:$printed_keys"
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
    sleep $update_delay
done
