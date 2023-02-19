#!/usr/bin/env sh

serverAdd=127.0.0.1:5000
recepients=""
tmpfile="tmp"
gpgout="tmp.gpg"
gpgverify="gpgtmp"
gpgdecrypted="gpgdec"
function imgproc { cp $1 $2; }
EDITOR="vim"
update_delay=1


source settings.d/*
