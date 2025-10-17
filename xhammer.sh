#!/usr/bin/env bash
mkdir tmp

echo
echo "Checking for yt-dlp updates..."
./yt-dlp_linux -U

xmlgetnext () {
local IFS='>'
read -d '<' TAG VALUE
}


while true; do

read -p "URL > " uri
rnd=$((1 + $RANDOM % 1000))
wget --quiet --convert-links "$uri" --output-document tmp/htmlout_$rnd.html
tagp=$(cat tmp/htmlout_$rnd.html | while xmlgetnext ; do echo $TAG | grep "_TPL_.h264.mp4"; done)

if [ -z "$tagp" ]; then tagp=$(cat tmp/htmlout_$rnd.html | while xmlgetnext ; do echo $TAG | grep "_TPL_.av1.mp4"; done); fi

uri="${tagp:25}"
uri="${uri%???????????????????????????????}"
tit=$(python3 ./gettitle.py $rnd)

./yt-dlp_linux -N 2 --file-access-retries 100 -R 100 --fragment-retries 100 --retry-sleep http:exp=1:20 --retry-sleep fragment:exp=1:20 -o "$tit".mp4 "$uri"
echo
echo "==========================================================="
echo
done
