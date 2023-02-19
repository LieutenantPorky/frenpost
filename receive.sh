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
        curl --silent $serverAdd/$i | gpg -d --output $gpgdecrypted 2> $gpgverify

        if file $gpgdecrypted | grep -q "image"; then
           echo "image"
           imgproc $gpgdecrypted "$i"
        elif file $gpgdecrypted | grep -q "text"; then
           echo "susamongus"
           cat $gpgdecrypted
        else
            echo "binary data"
        fi
        rm $gpgdecrypted

        signed=$(grep "Good signature" $gpgverify)
        echo "#-------------#"
        echo "$signed"
        echo "#-------------#"
        echo ""
        rm $gpgverify
    done
    sleep $update_delay
done
