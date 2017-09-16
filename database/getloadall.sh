#!/bin/bash

# ... 59735eb3efec720e0442affc/23-171376-1-FastGPS.csv - --- - 3 
# ... 59735eb3efec720e0442affc/23-171376-1-Locations.csv - --- - 3 
# psql -p 5433 -U dougt -w atndb -c "select 1;"
#
# select table_catalog,table_schema,table_name,column_name,ordinal_position,data_type
#   from information_schema.columns
#  where table_catalog = 'atndb' and table_schema = 'biologging' and table_name = 'atn_all';
#
# psql -p 5433 -U dougt -w -A -q atndb -c "
#         select column_name,ordinal_position,data_type
#           from information_schema.columns
#          where table_catalog = 'atndb' and table_schema = 'biologging' and table_name = 'atn_all';"

# cd /home/dougt/wc/wc/data.all

# for DIR in `ls -d 5*`
for DIR in `echo "596fcbcfefec720e04424f61"`
do
    echo "${DIR}"
    # for FILES in `ls ${DIR}/*.csv`

    # deal with (potential) multiple FastGPS and Locations files, could be two, but only
    # use the ##-######-#-FileType.csv instance

    for FILE_TYPE in `echo "FastGPS Locations"`
    do
        export RES="${FILES//[^-]}"
        export NUM=${#RES}
    done

    for FILE_TYPE in `echo "All Argos Corrupt HaulOut Histos Labels MinMaxDepth RawArgos RTC SST Status Summary"`
    # for FILE_TYPE in `echo "RTC"`
    do
        # there will be only 0 or 1 of each of these csv files
        for FILES in `ls ${DIR}/*-${FILE_TYPE}.csv 2> /dev/null`
        do
            export LINES=`wc -l ${FILES} | cut -d' ' -f1 `
            export LINEX=`echo ${LINES} - 1 | bc -l`

# 8,171361,6305,28.57637,-80.65329,3,07/19/2017 20:45:34,Argos,0,540,NP,,401677374.77,07/19/2017 20:46:42,1,5,0,-122,401677374.77,-80.65329,28.57637,-80.65329,28.57637,50,3,143,358,57,90,269,121,156,117,231,68,240,24,185,124,133,56,42,50,27,25,166,248,209,202,39,57,138,197,52,149,96,33,,,,,
# FIRST = echo ${LINE} | cut -d',' -f1-30
# ARRAY = echo ${LINE} | cut -d',' -f31-

            # before or after we need to create the array[] type value fields
            tail -${LINEX} ${FILES} | sed -f get.sed > /tmp/data_${FILE_TYPE}.bcp

            case ${FILE_TYPE} in 
            "All")
                # parse last xx values into ,"{1,2,3,4}" format into bcp file used for copy into
                # copy atn_all (deployid, platform_id, program_id, latitude, longitude, location_quality, location_date, location_type, altitude, data_pass, satellite, mote_id, frequency, message_date, comp, message, greater_120db, best_level, delta_frequency, longitude1, latitude_sol1, longitude2, latitude_sol2, location_index, nopc, error_radius, error_semi_major_axis, error_semi_minor_axis, error_ellipse_orient, gdop, data_sensor) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "Argos")
                # copy atn_all_argos (deployid, ptt, instrument, record_type, message_count, duplicates, corrupt, interval_avg, interval_min, date, satellite, location_quality, latitude1, longitude1, latitude2, longitude2, iq, duration, frequency, power) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "Corrupt")
                # copy atn_all_corrupt (deployid, ptt, instrument, date, duplicates, satellite, location_quality, latitude, longitude, reason, possible_timestamp, possible_type, bytes) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "HaulOut")
                # copy atn_all_haulout (deployid, ptt, instrument, data_id, date_start, date_end, duration, location_quality, latitude, longitude) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "Histos")
                # copy atn_all_histos (deployid, ptt, depth_sensor, source, instrument, histtype, data_date, time_offset, data_count, bad_therm, location_quality, latitude, longitude, numbins, data_sum, data_bin) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "Labels")
                # copy atn_all_labels (key, values) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "MinMaxDepth")
                # copy atn_all_minmaxdepth (deployid, ptt, depthsensor, instrument, data_date, location_quality, latitude, longitude, min_depth, min_accuracy, min_source, max_depth, max_accuracy, max_source) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "RawArgos")
                # copy atn_all_rawargos (program, ptt, length, satellite, data_class, pass, pass_date, pass_time, latitude1, longitude1, comment, frequency, power, iq, duplicates, message_date, message_time, latitude2, longitude2, duration, error_radius, error_semi_major_axis, error_semi_minor_axis, error_ellipse_orient, data_offset, offset_orient, data_sensor) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "RTC")
                echo "I am here in rtc..."
                # copy atn_all_rtc (deployid,ptt,instrument,correction_type,tag_date,tag_time,real_date,real_time) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "SST")
                # copy atn_all_sst (deployid, ptt, depth_sensor, instrument, data_date, location_quality, latitude, longitude, depth, temperature, data_source) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "Status")
                # copy atn_all_status (deployid, ptt, depth_sensor, instrument, sw, rtc, received, time_offset, location_quality, latitude, longitude, data_type, hauled_out, broken_thermistor, broken_link, transmits, battery_voltage, transmit_voltage, transmit_current, temperature, depth, max_depth, zero_depth_offset, light_level, no_dawn_dusk, release_type, release_time, initially_broken, burn_minutes, release_depth, fast_gps_power, twic_power, power_limit, wet_dry, wet_dry_min, wet_dry_max, wet_dry_threshold, status_word, transmit_power, resets, pre_rel_tilt, pre_rel_tilt_sd, pre_rel_tilt_count, xmit_queue, fast_gps_loc_number, fast_gps_failures, battery_disconnect) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            "Summary")
                # copy atn_all_summary (deployid, ptt, instrument, sw, percent_decoded, passes, percent_argos_loc, message_per_pass, ds, di, power_min, power_avg, power_max, min_interval, xmit_time_earliest, xmit_time_latest, xmit_days, data_time_earliest, data_time_latest, data_days, release_date, release_type, deploy_date) \
                #      from '/tmp/data.bcp' with (delimiter '|', null '');
                ;;
            *)
                echo "I am here in others..."
                ;;
            esac

            echo "... ${FILES} "
            # rm /tmp/data.bcp
        done
    done
done
exit


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

