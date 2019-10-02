#!/bin/bash

if [ -z "$1" ]
then
echo 1047171
fi

case "$1" in
--firstnames)
case "$2" in
-f)
egrep -v "(^#.*)" $3 | awk -F"|" '{print $3}' | sort -u | awk '{print $1}'
exit
;;
esac
;;
esac

case "$1" in
--lastnames)
case "$2" in
-f)
egrep -v "(^#.*)" $3 | awk -F"|" '{print $2}' | sort | awk '$1 != prev { print; prev=$1 }'
exit
;;
esac
;;
esac 

case "$1" in
--born-since)
case "$3" in
-f)
x=$2
case "$5" in
--born-until)
y=$6
egrep -v "(^#.*)" $4 | awk -F"|" -v dateA="$x" -v dateB="$y" '{if ($5 >= 'dateA' && $5 <= 'dateB') print}'
exit
;;
esac
egrep -v "(^#.*)" $4 | awk -F"|" -v dateA="$x" '{if ($5 >= 'dateA') print}'
exit
;;
esac
case "$3" in
--born-until)
case "$5" in
-f)
x=$2
y=$4
egrep -v "(^#.*)" $6 | awk -F"|" -v dateA="$x" -v dateB="$y" '{if ($5 >= 'dateA' && $5 <= 'dateB') print}'
exit
;;
esac
;;
esac
;;
esac

case "$1" in
--born-until)
case "$3" in
-f)
y=$2
case "$5" in
--born-since)
x=$6
egrep -v "(^#.*)" $4 | awk -F"|" -v dateA="$x" -v dateB="$y" '{if ($5 >= 'dateA' && $5 <= 'dateB') print}'
exit
;;
esac
egrep -v "(^#.*)" $4 | awk -F"|" -v dateA="$y" '{if ($5 <= 'dateA') print}'
exit
;;
esac
case "$3" in
--born-since)
case "$5" in
-f)
y=$2
x=$4
egrep -v "(^#.*)" $6 | awk -F"|" -v dateA="$x" -v dateB="$y" '{if ($5 >= 'dateA' && $5 <= 'dateB') print}'
exit
;;
esac
;;
esac
;;
esac

case "$1" in
--browsers)
case "$2" in
-f)
egrep -v "(^#.*)" $3 | awk -F"|" '{print $8}'| sort | uniq -c | awk '{print $2,$1}'
exit
;;
esac 
;;
esac

while getopts "f:id:" option;
do

case ${option} in
f)

if [ -z "$3" ]
then
cat ${OPTARG} | egrep -v "(^#.*)"
fi


case "$3" in
-id)
x=$4
awk -F"|" '{if ( $1 == '$x') print $3,$2,$5}' ${OPTARG}
;;
esac

case "$1" in
-id)
x=$2
awk -F"|" '{if ($1 == '$x') print $3,$2,$5}' ${OPTARG}
;;
esac

shift $((OPTIND-1))

case "$1" in
--firstnames)
egrep -v "(^#.*)" ${OPTARG} | awk -F"|" '{print $3}' | sort -u | awk '{print $1}'
;;
esac

case "$1" in
--lastnames)
egrep -v "(^#.*)" ${OPTARG} | awk -F"|" '{print $2}' | sort | awk '$1 != prev { print; prev=$1 }'
;;
esac

case "$1" in
--browsers)
egrep -v "(^#.*)" ${OPTARG} | awk -F"|" '{print $8}'| sort | uniq -c | awk '{print $2,$1}'
exit
;;
esac

case "$1" in
--born-since)
x=$2
case "$3" in
--born-until)
y=$4
egrep -v "(^#.*)" ${OPTARG} | awk -F"|" -v dateA="$x" -v dateB="$y" '{if ($5 >= 'dateA' && $5 <= 'dateB') print}'
exit
;;
esac
egrep -v "(^#.*)" ${OPTARG} | awk -F"|" -v dateA="$x" '{if ($5 >= 'dateA') print}'
exit
;;
esac
case "$1" in
--born-until)
y=$2
case "$3" in
--born-since)
x=$4
egrep -v "(^#.*)" ${OPTARG} | awk -F"|" -v dateA="$x" -v dateB="$y" '{if ($5 >= 'dateA' && $5 <= 'dateB') print}'
exit
;;
esac
egrep -v "(^#.*)" ${OPTARG} | awk -F"|" -v dateA="$y" '{if ($5 <= 'dateA') print}'
;;
esac
;;
esac
done

