#!/usr/bin/env sh

source ./settings.sh


rec_str=""
for i in $recepients; do
    rec_str="$rec_str -r $i"
done

if [ "$#" = 0 ] ; then
    ($EDITOR $tmpfile)
    gpg --output $gpgout $rec_str -se $tmpfile
    rm $tmpfile
else
    gpg --output $gpgout $rec_str -se "$1"
fi

curl --data-binary @$gpgout $serverAdd/post

rm $gpgout
