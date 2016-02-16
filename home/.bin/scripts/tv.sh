#!/bin/bash

echo

for n in '0' '1' '2' '3' '4' '5' '6' \
           '7' '8' '9' '10' '11' '12' '13';
  do
  for BG in 47m 43m 46m 42m 45m 41m 44m;
    do echo -en "$EINS\033[$BG        \033[0m";
  done
  echo;
done

for FGs in '0' '1';
  do FG=${FGs// /}
  for BG in 44m 40m 45m 40m 46m 40m 47m;
    do echo -en "$EINS\033[$BG        \033[0m";
  done
  echo;
done

for FGs in '0' '1' '2' '3' '4';
  do FG=${FGs// /}
  for BG in 44m 44m 44m 44m 44m 47m 47m 47m 47m 47m 45m 45m 45m 45m 45m 40m 40m 40m 40m 40m 40m 40m  40m 40m 40m 40m 40m 40m;
    do echo -en "$EINS\033[$BG  \033[0m";
  done
  echo;
done
echo
