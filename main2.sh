#!/bin/bash

#   7618442     24 -rw-rw-r--   1 dougt    dougt       24468 Sep  5 07:10 ./data/59711dd2efec720e0442736a.csv
export DIR="/home/dougt/wc/wc"

echo "<    Data File ----------------------- - ------------------------------------ - New Size - Old Size [diff>"

for FILE in `ls -1 data/5*.csv`
do
    export STR=`echo ${FILE} | cut -d'/' -f2 | cut -d '.' -f1`

    export FNEW=`ls -l data/${STR}.csv | sed -e"s/  / /g" | cut -d' ' -f5`
    typeset -i INEW=${FNEW}

    if [ -f "data.old/${STR}.csv" ]; then
        export FOLD=`ls -l data.old/${STR}.csv | sed -e"s/  / /g" | cut -d' ' -f5`
        typeset -i IOLD=${FOLD}
    else
        typeset -i IOLD=0
    fi

    if [ ${FNEW} != ${FOLD} ]; then
        export FLAG="---"
    else
        export FLAG=""
    fi

    printf "< %36s - %36s - %8s - %8s [%s]>\n" ${FILE} ${STR} ${INEW} ${IOLD} ${FLAG}
done

