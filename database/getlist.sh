#!/bin/bash

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
# exit

for WHICH in `echo All.csv Argos.csv Corrupt.csv HaulOut.csv Histos.csv Labels.csv Locations.csv MinMaxDepth.csv RawArgos.csv RTC.csv SST.csv Status.csv Summary.csv`
do
    echo "----- ${WHICH} -----------------------------------------"
    head -2 596fcbcfefec720e04424f61/*${WHICH} | tail -1
    echo ""
done

export WHICH="FastGPS.csv"
echo "----- ${WHICH} -----------------------------------------"
head -5 596fcbcfefec720e04424f61/*${WHICH} | tail -1

exit

"DeployID","Platform ID No.","Prg No.","Latitude","Longitude","Loc. quality","Loc. date","Loc. type","Altitude","Pass","Sat.","Mote Id","Frequency","Msg Date","Comp.","Msg","> - 120 DB","Best level","Delta freq.","Long. 1","Lat. sol. 1","Long. 2","Lat. sol. 2","Loc. idx","Nopc","Error radius","Semi-major axis","Semi-minor axis","Ellipse orientation","GDOP","SENSOR #01","SENSOR #02","SENSOR #03","SENSOR #04","SENSOR #05","SENSOR #06","SENSOR #07","SENSOR #08","SENSOR #09","SENSOR #10","SENSOR #11","SENSOR #12","SENSOR #13","SENSOR #14","SENSOR #15","SENSOR #16","SENSOR #17","SENSOR #18","SENSOR #19","SENSOR #20","SENSOR #21","SENSOR #22","SENSOR #23","SENSOR #24","SENSOR #25","SENSOR #26","SENSOR #27","SENSOR #28","SENSOR #29","SENSOR #30","SENSOR #31","SENSOR #32"

----- Argos.csv -----------------------------------------
==> 596fcbcfefec720e04424f61/171361-Argos.csv <==
DeployID,Ptt,Instr,RecordType,MsgCount,Duplicates,Corrupt,AvgInterval,MinInterval,Date,Satellite,LocationQuality,Latitude,Longitude,Latitude2,Longitude2,IQ,Duration,Frequency,Power

==> 596fcbcfefec720e04424f61/171361-RawArgos.csv <==
Prog,PTT,Len,Satellite,Class,Pass,PassDate,PassTime,Latitude,Longitude,Comment,Frequency,Power,IQ,Dups,MsgDate,MsgTime,Latitude2,Longitude2,Duration,Error radius,Error Semi-major axis,Error Semi-minor axis,Error Ellipse orientation,Offset,Offset orientation,SENSOR #01,SENSOR #02,SENSOR #03,SENSOR #04,SENSOR #05,SENSOR #06,SENSOR #07,SENSOR #08,SENSOR #09,SENSOR #10,SENSOR #11,SENSOR #12,SENSOR #13,SENSOR #14,SENSOR #15,SENSOR #16,SENSOR #17,SENSOR #18,SENSOR #19,SENSOR #20,SENSOR #21,SENSOR #22,SENSOR #23,SENSOR #24,SENSOR #25,SENSOR #26,SENSOR #27,SENSOR #28,SENSOR #29,SENSOR #30,SENSOR #31,SENSOR #32

----- Corrupt.csv -----------------------------------------
DeployID,Ptt,Instr,Date,Duplicates,Satellite,LocationQuality,Latitude,Longitude,Reason,Possible Timestamp,Possible Type,Byte 0,Byte 1,Byte 2,Byte 3,Byte 4,Byte 5,Byte 6,Byte 7,Byte 8,Byte 9,Byte 10,Byte 11,Byte 12,Byte 13,Byte 14,Byte 15,Byte 16,Byte 17,Byte 18,Byte 19,Byte 20,Byte 21,Byte 22,Byte 23,Byte 24,Byte 25,Byte 26,Byte 27,Byte 28,Byte 29,Byte 30,Byte 31

----- HaulOut.csv -----------------------------------------
DeployID,Ptt,Instr,Id,Start,End,Duration,LocationQuality,Latitude,Longitude

----- Histos.csv -----------------------------------------
DeployID,Ptt,DepthSensor,Source,Instr,HistType,Date,Time Offset,Count,BadTherm,LocationQuality,Latitude,Longitude,NumBins,Sum,Bin1,Bin2,Bin3,Bin4,Bin5,Bin6,Bin7,Bin8,Bin9,Bin10,Bin11,Bin12,Bin13,Bin14,Bin15,Bin16,Bin17,Bin18,Bin19,Bin20,Bin21,Bin22,Bin23,Bin24,Bin25,Bin26,Bin27,Bin28,Bin29,Bin30,Bin31,Bin32,Bin33,Bin34,Bin35,Bin36,Bin37,Bin38,Bin39,Bin40,Bin41,Bin42,Bin43,Bin44,Bin45,Bin46,Bin47,Bin48,Bin49,Bin50,Bin51,Bin52,Bin53,Bin54,Bin55,Bin56,Bin57,Bin58,Bin59,Bin60,Bin61,Bin62,Bin63,Bin64,Bin65,Bin66,Bin67,Bin68,Bin69,Bin70,Bin71,Bin72

----- Labels.csv -----------------------------------------
Key,Value(s)

----- Locations.csv -----------------------------------------
==> 596fcbcfefec720e04424f61/171361-Locations.csv <==
DeployID,Ptt,Instr,Date,Type,Quality,Latitude,Longitude,Error radius,Error Semi-major axis,Error Semi-minor axis,Error Ellipse orientation,Offset,Offset orientation,GPE MSD,GPE U,Count,Comment

==> 596fcbcfefec720e04424f61/8-171361-1-Locations.csv <==
DeployID,Ptt,Instr,Date,Type,Quality,Latitude,Longitude,Error radius,Error Semi-major axis,Error Semi-minor axis,Error Ellipse orientation,Offset,Offset orientation,GPE MSD,GPE U,Count,Comment

----- MinMaxDepth.csv -----------------------------------------
DeployID,Ptt,DepthSensor,Instr,Date,LocationQuality,Latitude,Longitude,MinDepth,MinAccuracy,MinSource,MaxDepth,MaxAccuracy,MaxSource

----- RawArgos.csv -----------------------------------------
Prog,PTT,Len,Satellite,Class,Pass,PassDate,PassTime,Latitude,Longitude,Comment,Frequency,Power,IQ,Dups,MsgDate,MsgTime,Latitude2,Longitude2,Duration,Error radius,Error Semi-major axis,Error Semi-minor axis,Error Ellipse orientation,Offset,Offset orientation,SENSOR #01,SENSOR #02,SENSOR #03,SENSOR #04,SENSOR #05,SENSOR #06,SENSOR #07,SENSOR #08,SENSOR #09,SENSOR #10,SENSOR #11,SENSOR #12,SENSOR #13,SENSOR #14,SENSOR #15,SENSOR #16,SENSOR #17,SENSOR #18,SENSOR #19,SENSOR #20,SENSOR #21,SENSOR #22,SENSOR #23,SENSOR #24,SENSOR #25,SENSOR #26,SENSOR #27,SENSOR #28,SENSOR #29,SENSOR #30,SENSOR #31,SENSOR #32

----- RTC.csv -----------------------------------------
DeployID,Ptt,Instr,CorrectionType,TagDate,TagTime,RealDate,RealTime

----- SST.csv -----------------------------------------
DeployID,Ptt,DepthSensor,Instr,Date,LocationQuality,Latitude,Longitude,Depth,Temperature,Source

----- Status.csv -----------------------------------------
DeployID,Ptt,DepthSensor,Instr,SW,RTC,Received,Time Offset,LocationQuality,Latitude,Longitude,Type,HauledOut,BrokenThermistor,BrokenLink,Transmits,BattVoltage,TransmitVoltage,TransmitCurrent,Temperature,Depth,MaxDepth,ZeroDepthOffset,LightLevel,NoDawnDusk,ReleaseType,ReleaseTime,InitiallyBroken,BurnMinutes,ReleaseDepth,FastGPSPower,TWICPower,PowerLimit,WetDry,MinWetDry,MaxWetDry,WetDryThreshold,StatusWord,TransmitPower,Resets,PreReleaseTilt,PreReleaseTiltSd,PreReleaseTiltCount,XmitQueue,FastGPSLocNumber,FastGPSFailures,BattDiscon

----- Summary.csv -----------------------------------------
DeployID,Ptt,Instr,SW,PercentDecoded,Passes,PercentArgosLoc,MsgPerPass,DS,DI,MinPower,AvgPower,MaxPower,MinInterval,EarliestXmitTime,LatestXmitTime,XmitDays,EarliestDataTime,LatestDataTime,DataDays,ReleaseDate,ReleaseType,DeployDate

----- FastGPS.csv -----------------------------------------
Name,Day,Time,Count,Time Offset,LocNumber,Failures,Hauled Out,Satellites,InitLat,InitLon,InitTime,InitType,Latitude,Longitude,Height,Bad Sats,Residual,Time Error,TWIC Power,Fastloc Power,Noise,Range Bits,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR,Id,Range,Signal,Doppler,CNR

#
# ---------------------------
#

----- All.csv -----------------------------------------
"8",171361,6305,28.57637,-80.65329,3,07/19/2017 20:45:34,Argos,0,540,NP,,401677374.77,07/19/2017 20:46:42,1,5,0,-122,401677374.77,-80.65329,28.57637,-80.65329,28.57637,50,3,143,358,57,90,269,121,156,117,231,68,240,24,185,124,133,56,42,50,27,25,166,248,209,202,39,57,138,197,52,149,96,33,,,,,

----- Argos.csv -----------------------------------------
6305,171361,27,NP,3,4,19-Jul-2017,20:45:34,28.5764,-80.6533,,401677374,-122,50,0,19-Jul-2017,20:46:42,28.5764,-80.6533,270,143,358,57,90,,,121,156,117,231,68,240,24,185,124,133,56,42,50,27,25,166,248,209,202,39,57,138,197,52,149,96,33,,,,,

----- Corrupt.csv -----------------------------------------
8,171361,Mk10,23:49:42 19-Jul-2017,,,3,28.3989,-80.8063,CRC 6599.47960,22:15:00 19-Jul-2016,Fast-GPS,113,156,113,231,100,240,24,185,60,133,56,42,50,27,25,166,248,209,202,39,61,138,5,52,149,96,33,,,,,

----- HaulOut.csv -----------------------------------------
8,171361,Mk10,1,18:21:00 19-Jul-2017,,,,,

----- Histos.csv -----------------------------------------
8,171361,,Transmission,Mk10,TAT,05:00:00 24-Jul-2017,2.000000,10,0,,,,12,100,0,0,0,0,0,0,57.6,42.4,0,0,0,0,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

----- Labels.csv -----------------------------------------
local tag id,8,

----- Locations.csv -----------------------------------------
8,171361,Mk10,20:15:00.860001 19-Jul-2017,FastGPS,,28.5771,-80.6533,,,,,,,,,,

----- MinMaxDepth.csv -----------------------------------------
8,171361,,Mk10,00:00:00 19-Jul-2017,,,,0.000000,0.000000,Status,,,

----- RawArgos.csv -----------------------------------------
6305,171361,27,NP,3,4,19-Jul-2017,20:45:34,28.5764,-80.6533,,401677374,-122,50,0,19-Jul-2017,20:46:42,28.5764,-80.6533,270,143,358,57,90,,,121,156,117,231,68,240,24,185,124,133,56,42,50,27,25,166,248,209,202,39,57,138,197,52,149,96,33,,,,,

----- RTC.csv -----------------------------------------
8,171361,Mk10,Strong,19-Jul-2017,23:19:40,19-Jul-2017,23:19:42

----- SST.csv -----------------------------------------
8,171361,,Mk10,11:00:00 26-Jul-2017,,,,0.0,26.6,Status

----- Status.csv -----------------------------------------
8,171361,,Mk10,,23:19:40 19-Jul-2017,23:19:42 19-Jul-2017,2,3,28.3982,-80.8075,CRC,1,0,,,,1.008,0.124,,,0.0,0,,,,,,,,,,,255,255,255,80,,,,,,,,11,8,

----- Summary.csv -----------------------------------------
8,171361,Mk10,,79,519,100,3,1491,,,,,14,20:45:34 19-Jul-2017,15:04:28 31-Aug-2017,43,20:15:00 19-Jul-2017,10:18:28 31-Aug-2017,43,,,

----- FastGPS.csv -----------------------------------------
8,19-Jul-2017,20:15:00,10,2.000000,1,8,1,6,28.5771,-80.6533,20:15:00.860001 19-Jul-2017,FastGPS,28.5771,-80.6533,,,8.8,-1.1,,,,15,5,26098,,,,2,19978,,,,17,18540,,,,12,27070,,,,6,18216,,,,19,20066,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,


