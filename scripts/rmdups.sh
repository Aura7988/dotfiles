#!/bin/bash

src=~/.bash_history
bak=~/.old.bash_history
tmp=~/`date +%s`.txt
p='^cd( | *$)|^vi( | *$|mdiff )|^z |^echo |^cat |^rm |^mv |^cp |^mkdir |^tar |^fg( | *$)|^man |^wget |^md5sum |^rg |^kill |^git (a|cm|df|sr|show|diff) |^l(a|l|s)( | *$)'

cp $src $bak && sed -r "/$p/d; s/\s+$//" $bak | tac | awk '!a[$0]++' | tac > $tmp && mv $tmp $src
