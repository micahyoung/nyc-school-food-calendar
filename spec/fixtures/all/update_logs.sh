#!/bin/bash
if ! [ -f ./run.rb ]; then
  echo execute from app root
  exit 1
fi

for f in $(dirname $0)/*.pdf; do
  for i in {1..31}; do
    echo $i --------
    ruby ./run.rb $f $i;
    echo   --------
  done > $f.log;
done
