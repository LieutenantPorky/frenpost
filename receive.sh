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
        signed=$(grep "Good signature" $gpgverify)

        if file $gpgdecrypted | grep -q "image"; then
           if [ -n "$signed" ]; then
              echo "image sent by $signed"
              imgproc $gpgdecrypted "$i"
           else
               echo "someone's a sussy baka and tried to send an unsigned image!"
           fi
        elif file $gpgdecrypted | grep -q "text"; then
           cat $gpgdecrypted
        else
           if [ -n "$signed" ]; then
              echo "binary data"
              binproc $gpgdecrypted "$i"
           else
               echo "someone's a sussy baka and tried to send an unsigned image!"
           fi
        fi
        rm $gpgdecrypted

        echo "#-------------#"
        echo "$signed"
        echo "#-------------#"
        echo ""
        rm $gpgverify
    done
    sleep $update_delay
done
