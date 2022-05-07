#!/bin/bash


#Simple bash script to remove Docker containers older then 4weeks

max_week_size=4
docker images | awk 'NR>1 {print $0}' | while read line; do
    # echo $line
    id_img=$(echo $line | awk '{print $3}')

    # if older then a month
    is_month=$(echo $line | grep 'month')
    if [ ! -z "$is_month" ]; then 
        echo $id_img
        docker rmi -f $id_img
        continue
    fi

    # remove older then 4 weeks
    num_week=$(echo $line | grep "week" | awk '{print $4}')
    if [ ! -z "$num_week" ] && [ $num_week -ge $max_week_size ]; then 
        echo $id_img
        docker rmi -f $id_img
    fi
done