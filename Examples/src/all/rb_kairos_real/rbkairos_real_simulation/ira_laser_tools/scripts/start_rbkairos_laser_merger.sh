#!/usr/bin/env bash

BLUETEXT="\033[1;34m"
REDTEXT="\033[1;31m"
WHITETEXT="\033[0;37m"
GREENTEXT="\033[1;32m"


function ros_env_setup {
    echo -e "$BLUETEXT\nSetting up ROS env"
    set +x
    . /home/user/.bashrc
    set -x
    echo -e "$BLUETEXT\nSetting up ROS env DONE"
    echo -e "\n$WHITETEXT"
}


function start_lasermerge {

    # We check that the needed topics are present and then launch the merger

    expected_topics=(
        "/robot/front_laser/scan"
        "/robot/rear_laser/scan"
    )

    echo "Checking Topics..."$expected_topics
    for topic in "${expected_topics[@]}"; do
        echo "Waiting for..."$topic
        rostopic echo $topic -n1
    done
    echo -e "$BLUETEXT\nLasers Ready to be merged"
    echo -e "\n$WHITETEXT"

    roslaunch ira_laser_tools laserscan_multi_merger_kairos.launch

}


function main {
    set -x
    set -e
    ros_env_setup
    start_lasermerge
    set +e
    set +x

}

main
echo -e "$GREENTEXT\nFinished start_lasermerge"
echo -e "\n$WHITETEXT"
