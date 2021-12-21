#!/bin/bash

host1=habr.com
host2=173.194.222.113
host3=22.242.532.1

hosts=("$host1" "$host2" "$host3")

while [ 1==1 ]
do
        declare -i err
        for h in ${hosts[@]}
        do
                for (( i=1; i <= 3; i++ ))
                do
                        curl $h
                        err=$?
                        if [ "$err" -ne 0 ]
                        then
                                echo Host $h has been disabled! >> curl.log
                                break 3
                        fi
                        sleep 1
                done
        done
done