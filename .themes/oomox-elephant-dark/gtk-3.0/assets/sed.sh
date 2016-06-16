#!/bin/sh
sed -i \
         -e 's/#212121/rgb(0%,0%,0%)/g' \
         -e 's/#dcdcdc/rgb(100%,100%,100%)/g' \
    -e 's/#212121/rgb(50%,0%,0%)/g' \
     -e 's/#e8586e/rgb(0%,50%,0%)/g' \
     -e 's/#2b2b2b/rgb(50%,0%,50%)/g' \
     -e 's/#dcdcdc/rgb(0%,0%,50%)/g' \
	*.svg
