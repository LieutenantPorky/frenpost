#!/usr/bin/env sh

#address of the frenpost server to connect to
serverAdd=127.0.0.1:5000

#who's public keys to encrypt with
recepients=""

tmpfile="tmp"
gpgout="tmp.gpg"
gpgverify="gpgtmp"
gpgdecrypted="gpgdec"

#where to save images
imgdir="pictures"
function imgproc {
    mkdir -p "$imgdir"
    cp "$1" "$imgdir/$2"; }

#where to save other binary files
bindir="other"
function binproc {
    mkdir -p "$bindir"
    cp "$1" "$bindir/$2"; }

EDITOR="vim"
update_delay=1


source settings.d/*
