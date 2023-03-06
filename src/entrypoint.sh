#!/bin/bash

#Set fonts
NORM=`tput sgr0`
BOLD=`tput bold`
REV=`tput smso`

function show_usage () {
    echo -e "${BOLD}Basic usage:${NORM} entrypoint.sh [-vh] persons-file homes-file output-path"
}

function show_help () {
    echo -e "${BOLD}entrypoint.sh${NORM}: Moves the data as outputs"\\n
    show_usage
    echo -e "\n${BOLD}Required arguments:${NORM}"
    echo -e "${REV}persons-path${NORM}\t\t the path of the persons file"
    echo -e "${REV}homes-path${NORM}\t\t the path of the homes file"
    echo -e "${REV}out-dir${NORM}\t\t\t the output directory"\\n
    echo -e "${BOLD}Optional arguments:${NORM}"
    echo -e "${REV}-v${NORM}\tSets verbosity level"
    echo -e "${REV}-h${NORM}\tShows this message"
    echo -e "${BOLD}Examples:${NORM}"
    echo -e "./entrypoint.sh -v ./sample-data/input/persons.csv ./sample-data/input/homes.gpkg ./sample-data/output/"
}

####################################################################################################
# GETOPTS                                                                                          #
####################################################################################################
# A POSIX variable
# Reset in case getopts has been used previously in the shell.
OPTIND=1

# Initialize vars:
verbose=0

# while getopts
while getopts 'hv' OPTION; do
    case "$OPTION" in
        h)
            show_help
            kill -INT $$
            ;;
        v)
            verbose=1
            ;;
        ?)
            show_usage >&2
            kill -INT $$
            ;;
    esac
done

shift "$(($OPTIND -1))"

leftovers=(${@})
fpersons=${leftovers[0]}
fhomes=${leftovers[1]}
outdir=${leftovers[2]%/}

####################################################################################################
# Input checks                                                                                     #
####################################################################################################
if [ ! -f "${fpersons}" ]; then
     echo -e "Give a ${BOLD}valid${NORM} output persons file path\n"; show_usage; kill -INT $$
fi
if [ ! -f "${fhomes}" ]; then
     echo -e "Give a ${BOLD}valid${NORM} output homes file path\n"; show_usage; kill -INT $$
fi

if [ ! -d "${outdir}" ]; then
     echo -e "Give a ${BOLD}valid${NORM} output directory\n"; show_usage; kill -INT $$
fi

####################################################################################################
# Execution                                                                                        #
####################################################################################################
cp ${fpersons} ${outdir}/persons.csv
cp ${fhomes} ${outdir}/homes.gpkg

[ $verbose -eq 1 ] && echo -e "output:\n$(ls -ld -1 ${outdir}/*)"
