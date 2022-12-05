#!/usr/bin/env sh

serverAdd=127.0.0.1:5000
recepients="jacopo erche bernie anton"
tmpfile="tmp"
EDITOR="vim"

rec_str=""
for i in $recepients; do
    rec_str="$rec_str -r $i"
done

if [ "$#" = 0 ] ; then
    ($EDITOR $tmpfile)
    message=$(gpg --output \- $rec_str -se $tmpfile)
    rm $tmpfile
else
    message=$(gpg --output \- $rec_str -se $1)
fi

curl --data-raw "$message" $serverAdd/post
