#!/usr/bin/env bash

mapfile -t content < input.txt

pass=0

for line in "${content[@]}"
do
    arr=($line)
    length="${#arr[@]}"
    trend=""

    for (( i=0; i < length - 1; i++ ))
    do
        diff=$(( arr[i + 1] - arr[i] ))

        if [[ ( $diff -ge -3 && $diff -le -1 ) && ( $trend = "-" || $trend = "" ) ]]
        then
            trend="-"
        elif [[ ( $diff -ge 1 && $diff -le 3 ) && ( $trend = "+" || $trend = "" ) ]]
        then
            trend="+"
        else
            break
        fi

        if [ $i = $(( length - 2 )) ]
        then
            (( pass++ ))
        fi
    done
done

echo "$pass"
