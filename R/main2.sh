#!/bin/bash

#   7618442     24 -rw-rw-r--   1 dougt    dougt       24468 Sep  5 07:10 ./data/59711dd2efec720e0442736a.csv
export DIR="/home/dougt/wc/wc"

for FILE in `ls -1 data/*.csv`
do
    export STR=`echo ${FILE} | cut -d'/' -f2 | cut -d '.' -f1`
    export FNEW=`ls -l data/${STR}.csv | sed -e"s/  / /g" | cut -d' ' -f5`
    export FOLD=`ls -l data.old/${STR}.csv | sed -e"s/  / /g" | cut -d' ' -f5`

    typeset -i INEW=${FNEW}
    typeset -i IOLD=${FOLD}
    if [ ${FNEW} != ${FOLD} ]; then
        export FLAG="---"
    else
        export FLAG=""
    fi

    printf "< %36s - %36s - %8s - %8s [%s]>\n" ${FILE} ${STR} ${FNEW} ${FOLD} ${FLAG}
done

