#!/bin/bash

echo "What is your origin name?"
read -s name

echo "Your origin is $name [Y/N]"
read -s ansr

if [ "$ansr" = "Y" ]; then
 for fle in `find . | xargs grep -sl myorigin | grep -v change_origin.sh`
  do
   sed -i "" "s/myorigin/$name/g" $fle
  done
fi

echo "myorigin files:"
find . | xargs grep -sl myorigin | grep -v change_origin.sh

echo "$name files:"
find . | xargs grep -sl $name
# for file in `find . | xargs grep -sl myorigin | grep -v change_origin.sh` do
#
# sed -i 's/original/new/g' file
