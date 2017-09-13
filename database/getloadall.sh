#!/bin/bash

# ... 59735eb3efec720e0442affc/23-171376-1-FastGPS.csv - --- - 3 
# ... 59735eb3efec720e0442affc/23-171376-1-Locations.csv - --- - 3 

# cd /home/dougt/wc/wc/data.all

# for DIR in `ls -d 5*`
for DIR in `echo "596fcbcfefec720e04424f61"`
do
    echo "${DIR}"
    # for FILES in `ls ${DIR}/*.csv`

    # deal with (potential) multiple FastGPS and Locations files
    for FILE_TYPE in `echo "FastGPS Locations"`
    do
        export RES="${FILES//[^-]}"
        export NUM=${#RES}
    done

    # for FILE_TYPE in `echo "All Argos Corrupt HaulOut Histos Labels MinMaxDepth RawArgos RTC SST Status Summary"`
    for FILE_TYPE in `echo "RTC"`
    do
        for FILES in `ls ${DIR}/*${FILE_TYPE}.csv 2> /dev/null`
        do
            export LINES=`wc -l ${FILES} | cut -d' ' -f1 `
            export LINEX=`echo ${LINES} - 1 | bc -l`

            tail -${LINEX} ${FILES} | sed -f get.sed > tmp_${FILE_TYPE}.bcp

            echo "... ${FILES} "
        done
    done
done
exit

copy atn_all_rtc (deployid,ptt,instr,correction_type,tag_date,tag_time,real_date,real_time) from '/home/dougt/wc/wc/data.all/tmp_RTC.bcp' with (delimiter '|');

for FILES in `find . -name "*.csv" -print`
do
    export RES="${FILES//[^-]}"
    export NUM=${#RES}

    if [ "${NUM}" == "1" ]; then
        export FILE=`echo ${FILES} | cut -d'-' -f2`
    else
        export FILE=`echo ${FILES} | cut -d'-' -f4`
    fi
    echo " [${NUM}] - ${FILE} - ${FILES} "
done

-rw-rw-r-- 1 dougt dougt 1127 Sep 12 09:08 atn_all_argos.sql
-rw-rw-r-- 1 dougt dougt 1599 Sep 12 09:15 atn_all_corrupt.sql
-rw-rw-r-- 1 dougt dougt 2070 Sep 12 09:15 atn_all_fastgps.sql
-rw-rw-r-- 1 dougt dougt  821 Sep 12 09:10 atn_all_haulout.sql
-rw-rw-r-- 1 dougt dougt 1753 Sep 12 09:11 atn_all_histos.sql
-rw-rw-r-- 1 dougt dougt  282 Sep 12 09:24 atn_all_labels.sql
-rw-rw-r-- 1 dougt dougt 1459 Sep 12 09:11 atn_all_locations.sql
-rw-rw-r-- 1 dougt dougt 1141 Sep 12 09:12 atn_all_minmaxdepth.sql
-rw-rw-r-- 1 dougt dougt 2302 Sep 12 09:13 atn_all_rawargos.sql
-rw-rw-r-- 1 dougt dougt  622 Sep 12 09:13 atn_all_rtc.sql
-rw-rw-r-- 1 dougt dougt 2686 Sep 11 15:27 atn_all.sql
-rw-rw-r-- 1 dougt dougt  834 Sep 12 09:14 atn_all_sst.sql
-rw-rw-r-- 1 dougt dougt 3724 Sep 12 09:14 atn_all_status.sql
-rw-rw-r-- 1 dougt dougt 1857 Sep 12 09:15 atn_all_summary.sql

$... 59735eb3efec720e0442affc/171376-All.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-Argos.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-Corrupt.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-FastGPS.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-HaulOut.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-Histos.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-Labels.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-Locations.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-MinMaxDepth.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-RawArgos.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-RTC.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-SST.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-Status.csv - - - 1 
$... 59735eb3efec720e0442affc/171376-Summary.csv - - - 1 

