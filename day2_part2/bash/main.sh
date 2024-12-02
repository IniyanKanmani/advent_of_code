#!/usr/bin/env bash

mapfile -t content < input.txt

function full_check() {
    local arr=($@)
    local length="${#arr[@]}"
    local trend=""

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
            return 0
        fi
    done

    return 1
}

pass=0

for line in "${content[@]}"
do
    arr=($line)
    length="${#arr[@]}"
    full_check "${arr[@]}"

    if [[ $? = 0 ]]
    then
        (( pass++ ))
        continue
    else
        for (( j=0; j < length; j++ ))
        do
            new_arr=("${arr[@]}")
            unset new_arr[$j]

            full_check "${new_arr[@]}"

            if [[ $? = 0 ]]
            then
                (( pass++ ))
                break
            fi
        done
    fi
done

echo "$pass" # 308
