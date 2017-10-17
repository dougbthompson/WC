#!/bin/bash

# ./main3.sh            ....... for SSM tracks
# ./main3.sh .csv csv   ....... for 5---.csv files

export PREFIX1=""
export POSTFIX1=$1
if [ "${POSTFIX1}" == "" ]; then
    export POSTFIX1="SSM.txt"
fi
export POSTFIX2=$2
if [ "${POSTFIX2}" == "" ]; then
    export POSTFIX2="txt"
fi

if [ "${POSTFIX2}" == "csv" ]; then
    PREFIX1="5"
fi

export DIR="/home/dougt/wc/wc"

export BREAK="NO"
echo "<    Data File --------------------- - NewSize - OldSize -  BDiff -  LDiff - [Diff] >"

for FILE in `ls -1 data/${PREFIX1}*${POSTFIX1}`
do
    export STR=`echo ${FILE} | cut -d'/' -f2 | cut -d '.' -f1`

    export PRE=${STR:0:4}
    if [ "${PRE}" != "2000" ]; then
        if [ "${BREAK}" == "NO" ]; then
            # printf "\n"
            export BREAK="YES"
        fi
    fi

    typeset -i LNEW=`wc -l data/${STR}.${POSTFIX2} | cut -d' ' -f1`
    export FNEW=`ls -l data/${STR}.${POSTFIX2} | sed -e"s/  / /g" | cut -d' ' -f5`
    typeset -i INEW=${FNEW}

    if [ -f "data.old/${STR}".${POSTFIX2} ]; then
        export LOLD=`wc -l data.old/${STR}.${POSTFIX2} | cut -d' ' -f1`
        export FOLD=`ls -l data.old/${STR}.${POSTFIX2} | sed -e"s/  / /g" | cut -d' ' -f5`
        typeset -i IOLD=${FOLD}
    else
        typeset -i LOLD=0
        typeset -i IOLD=0
    fi

    typeset -i BDIFF=`expr ${INEW} - ${IOLD}`
    typeset -i LDIFF=`expr ${LNEW} - ${LOLD}`

    if [ ${FNEW} != ${FOLD} ]; then
        export FLAG="----"
    else
        export FLAG="    "
    fi

    printf "< %34s - %7s - %7s - %6s - %6s - [%4s] >\n" ${FILE} ${INEW} ${IOLD} ${BDIFF} ${LDIFF} ${FLAG} 
done

