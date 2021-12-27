#!/usr/bin/env bash

# Simple calculator script
# Use it by adding a new mode, e.g.:
# rofi -show run -modi calc: ~/.config/rofi/calculator.sh
ROFI_CALC_HISTORY_FILE=~/.local/share/rofi/calc_history
ROFI_CALC_HISTORY_MAXCOUNT=10 # maximum number of history entries

# Create the directory for the files of the script
if [ ! -d $(dirname "${CALC_HISTORY_FILE}") ]
then
    mkdir -p "$(dirname "${CALC_HISTORY_FILE}")"
fi

if [ -z $@ ]
then
    cat ${ROFI_CALC_HISTORY_FILE}
else
    FORMULA=$@

    if [ -n "${FORMULA}" ]
    then
        if [[ "${FORMULA}" =~ "=" ]]
        then
           OUTPUT=${FORMULA}
       else
            RESULT=`echo "${FORMULA}" | bc -l`
            OUTPUT="${FORMULA} = ${RESULT}"
        fi
        echo -e "${OUTPUT}\n$(cat ${ROFI_CALC_HISTORY_FILE})" > ${ROFI_CALC_HISTORY_FILE}
        if [ $( wc -l < "${ROFI_CALC_HISTORY_FILE}" ) -gt ${ROFI_CALC_HISTORY_MAXCOUNT} ]
        then
            echo "$(head -n ${ROFI_CALC_HISTORY_MAXCOUNT} ${ROFI_CALC_HISTORY_FILE})" > ${ROFI_CALC_HISTORY_FILE}
        fi
        cat ${ROFI_CALC_HISTORY_FILE}
    fi
fi