#!/bin/bash
#
# About: LSDyna Script automatically
# Author: liberodark
# Thanks : 
# License: GPLv3

version="0.0.9"

echo "LSDyna use Script $version"

#=================================================
# RETRIEVE ARGUMENTS FROM THE MANIFEST AND VAR
#=================================================

export LSTC_LICENSE=network
export LSTC_LICENSE_SERVER=10.10.161.7
export LSTC_LICENSE_SERVER_PORT=31010
LSDYNA_DIR="/opt/lsdyna"
#LSDYNA_USER="lsdyna"
whoami="$(whoami)"
date=$(date +%Y.%m.%d_%H-%M-%S)

usage ()
{
     echo "usage: lsdyna dsmp_611 i=myfile.k ncpu=8 memory=1500M"
     echo "available versions :"
     echo "dsmp_611 : Use LSDyna SMP D R611"
     echo "dsmp_931 : Use LSDyna SMP D R931"
     echo "ssmp_1020 : Use LSDyna SMP S R1020"
     echo "dsmp_1020 : Use LSDyna SMP D R1020"
     echo "ssmp_1110 : Use LSDyna SMP S R1110"
     echo "dsmp_1110 : Use LSDyna SMP D R1110"
     echo "ssmp_1300 : Use LSDyna SMP S R1300"
     echo "dsmp_1300 : Use LSDyna SMP D R1300"
     echo "-h: Show help"
}


set_smp_d_611(){
    if test -e "${LSDYNA_DIR}/ls-dyna_smp_d_R6_1_1"; then
        export RUN_APP="${LSDYNA_DIR}/ls-dyna_smp_d_R6_1_1"
    else
        echo "Error file is not found : ${LSDYNA_DIR}/ls-dyna_smp_d_R6_1_1"
        exit
    fi
}

set_smp_d_931(){
    if test -e "${LSDYNA_DIR}/ls-dyna_smp_d_R9_3_1"; then
        export RUN_APP="${LSDYNA_DIR}/ls-dyna_smp_d_R9_3_1"
    else
        echo "Error file is not found : ${LSDYNA_DIR}/ls-dyna_smp_d_R9_3_1"
        exit
    fi
}

set_smp_s_1020(){
    if test -e "${LSDYNA_DIR}/ls-dyna_smp_s_R10_2_0"; then
        export RUN_APP="${LSDYNA_DIR}/ls-dyna_smp_s_R10_2_0"
    else
        echo "Error file is not found : ${LSDYNA_DIR}/ls-dyna_smp_s_R10_2_0"
        exit
    fi
}

set_smp_d_1020(){
    if test -e "${LSDYNA_DIR}/ls-dyna_smp_d_R10_2_0"; then
        export RUN_APP="${LSDYNA_DIR}/ls-dyna_smp_d_R10_2_0"
    else
        echo "Error file is not found : ${LSDYNA_DIR}/ls-dyna_smp_d_R10_2_0"
        exit
    fi
}

set_smp_s_1110(){
    if test -e "${LSDYNA_DIR}/ls-dyna_smp_s_R11_1_0"; then
        export RUN_APP="${LSDYNA_DIR}/ls-dyna_smp_s_R11_1_0"
    else
        echo "Error file is not found : ${LSDYNA_DIR}/ls-dyna_smp_s_R11_1_0"
        exit
    fi
}

set_smp_d_1110(){
    if test -e "${LSDYNA_DIR}/ls-dyna_smp_d_R11_1_0"; then
        export RUN_APP="${LSDYNA_DIR}/ls-dyna_smp_d_R11_1_0"
    else
        echo "Error file is not found : ${LSDYNA_DIR}/ls-dyna_smp_d_R11_1_0"
        exit
    fi
}

set_smp_s_1300(){
    if test -e "${LSDYNA_DIR}/ls-dyna_smp_s_R13_0_0"; then
        export RUN_APP="${LSDYNA_DIR}/ls-dyna_smp_s_R13_0_0"
    else
        echo "Error file is not found : ${LSDYNA_DIR}/ls-dyna_smp_s_R13_0_0"
        exit
    fi
}

set_smp_d_1300(){
    if test -e "${LSDYNA_DIR}/ls-dyna_smp_d_R13_0_0"; then
        export RUN_APP="${LSDYNA_DIR}/ls-dyna_smp_d_R13_0_0"
    else
        echo "Error file is not found : ${LSDYNA_DIR}/ls-dyna_smp_d_R13_0_0"
        exit
    fi
}

run_lsdyna(){
    exec screen -U -dmS "${whoami}"_"${date}" "${RUN_APP}" "$@" | return 0
}

check_lsdyna(){
echo "Please wait, We are trying to find your session" && sleep 5s

    if screen -ls "${whoami}"_"${date}" > /dev/null 2>&1; then
        echo "Your session is : ${whoami}_${date}"
        exit
    else
        echo "Error no screen session is running"
        exit
    fi
}

parse_args ()
{
    while [ $# -ne 0 ]
    do
        case "${1}" in
            dsmp_611)
                shift
                set_smp_d_611
                run_lsdyna "$@"
                check_lsdyna
                ;;
            dsmp_931)
                shift
                set_smp_d_931
                run_lsdyna "$@"
                check_lsdyna
                ;;
            ssmp_1020)
                shift
                set_smp_s_1020
                run_lsdyna "$@"
                check_lsdyna
                ;;
            dsmp_1020)
                shift
                set_smp_d_1020
                run_lsdyna "$@"
                check_lsdyna
                ;;
            ssmp_1110)
                shift
                set_smp_s_1110
                run_lsdyna "$@"
                check_lsdyna
                ;;
            dsmp_1110)
                shift
                set_smp_d_1110
                run_lsdyna "$@"
                check_lsdyna
                ;;
            ssmp_1300)
                shift
                set_smp_s_1300
                run_lsdyna "$@"
                check_lsdyna
                ;;
            dsmp_1300)
                shift
                set_smp_d_1300
                run_lsdyna "$@"
                check_lsdyna
                ;;
            -h|--help)
                usage
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
