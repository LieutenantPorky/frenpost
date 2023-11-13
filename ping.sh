#!/usr/bin/env sh

source ./settings.sh

while true; do

    # Gets the keys
    keys=$(curl --silent $serverAdd/post_id)

    # No folder - create one and add keys to it.
    if [[ ! -e ${tmpcheck} ]]; then
        echo "Saving keys to memory.";
        echo "Done.";
        echo $keys >> $tmpcheck;
        continue;
    fi

    # Empty folder - add keys to it.
    if [ $(wc -l < "${tmpcheck}") -eq 0 ]; then
        echo "Saving keys to memory.";
        echo "Done.";
        echo $keys >> $tmpcheck;
        continue;
    fi

    # Store keys to file
    echo $keys >> $tmpcheck2;

    # Get keys from the two temporary files.
    # (Here, we 'redundantly' stored $keys to file and then 
    # pulled it back to memory... This is because the strings
    # were unequal for some reason).
    tmp_memory=$(<$tmpcheck);
    tmp_memory2=$(<$tmpcheck2);

    # If the files don't match, you have mail! >:) 
    # We also need to update the 'memory file', in that case.
    if [[ "$tmp_memory" != "$tmp_memory2" ]]; then
        notify-send "You have mail >:)." --expire-time=1000000 --wait --app-name=frenpost;
        rm $tmpcheck;
    fi

    # Sleepy-sleep in case the bois are spamming the gc, again.
    sleep 2;

    # Also reset temporary file.
    rm $tmpcheck2;

done
