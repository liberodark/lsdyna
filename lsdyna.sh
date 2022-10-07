#!/bin/bash
#
# About: LSDyna Script automatically
# Author: liberodark
# Thanks : 
# License: GPLv3

version="0.0.4"

echo "LSDyna use Script $version"

#=================================================
# RETRIEVE ARGUMENTS FROM THE MANIFEST AND VAR
#=================================================

export LSTC_LICENSE=network
export LSTC_LICENSE_SERVER=10.10.161.7
export LSTC_LICENSE_SERVER_PORT=31010
whoami="$(whoami)"
date=$(date +%Y.%m.%d_%H-%M-%S)

usage ()
{
     echo "usage: lsdyna dsmp_611 i=myfile.k ncpu=8 memory=1500M"
     echo "available versions :"
     echo "dsmp_611: Use LSDyna SMP D R611"
     echo "dsmp_931: Use LSDyna SMP D R931"
     echo "ssmp_1020: Use LSDyna SMP S R1020"
     echo "dsmp_1020: Use LSDyna SMP D R1020"
     echo "ssmp_1110: Use LSDyna SMP S R1110"
     echo "dsmp_1110: Use LSDyna SMP D R1110"
     echo "ssmp_1300: Use LSDyna SMP S R1300"
     echo "dsmp_1300: Use LSDyna SMP D R1300"
     echo "-h: Show help"
}


set_smp_d_611(){
export RUN_APP="/opt/lsdyna/ls-dyna_smp_d_R6_1_1"
}

set_smp_d_931(){
export RUN_APP="/opt/lsdyna/ls-dyna_smp_d_R9_3_1"
}

set_smp_s_1020(){
export RUN_APP="/opt/lsdyna/ls-dyna_smp_s_R10_2_0"
}

set_smp_d_1020(){
export RUN_APP="/opt/lsdyna/ls-dyna_smp_d_R10_2_0"
}

set_smp_s_1110(){
export RUN_APP="/opt/lsdyna/ls-dyna_smp_s_R11_1_0"
}

set_smp_d_1110(){
export RUN_APP="/opt/lsdyna/ls-dyna_smp_d_R11_1_0"
}

set_smp_s_1300(){
export RUN_APP="/opt/lsdyna/ls-dyna_smp_s_R13_0_0"
}

set_smp_d_1300(){
export RUN_APP="/opt/lsdyna/ls-dyna_smp_d_R13_0_0"
}

session_lsdyna(){
echo "Your session is : ${whoami}_${date}"
}

run_lsdyna(){
exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@"
}

parse_args ()
{
    while [ $# -ne 0 ]
    do
        case "${1}" in
            dsmp_611)
                shift
                set_smp_d_611
                session_lsdyna
                run_lsdyna "$@"
                ;;
            dsmp_931)
                shift
                set_smp_d_931
                session_lsdyna
                exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@"
                ;;
            ssmp_1020)
                shift
                set_smp_s_1020
                session_lsdyna
                exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@"
                ;;
            dsmp_1020)
                shift
                set_smp_d_1020
                session_lsdyna
                exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@"
                ;;
            ssmp_1110)
                shift
                set_smp_s_1110
                session_lsdyna
                exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@"
                ;;
            dsmp_1110)
                shift
                set_smp_d_1110
                session_lsdyna
                exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@"
                ;;
            ssmp_1300)
                shift
                set_smp_s_1300
                session_lsdyna
                exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@"
                ;;
            dsmp_1300)
                shift
                set_smp_d_1300
                session_lsdyna
                exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@"
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo "Invalid argument : ${1}" >&2
                usage >&2
                exit 1
                ;;
        esac
        shift
    done

}

parse_args "$@"
