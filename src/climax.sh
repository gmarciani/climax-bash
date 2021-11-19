#!/bin/bash
set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# shellcheck disable=SC1091
source "${PROJECT_DIR}/lib/logging.sh"
# shellcheck disable=SC1091
source "${PROJECT_DIR}/lib/exit_codes.sh"
# shellcheck disable=SC1091
source "${PROJECT_DIR}/lib/regex.sh"

function helper () {
    _cmd=$(basename "$0")
    echo "${CYAN}$(cat "${PROJECT_DIR}/lib/splash.txt")${NOCOLOR}"
    echo ""
    echo ""
    echo "Usage: $_cmd [OPTIONS] COMMAND [ARGS]"
    echo ""
    echo "Commands:"
    echo ""
    echo "  command1  Executes the 1st command."
    echo "  command2  Executes the 2nd command."
    echo ""
    echo "Options:"
    echo ""
    echo "  --string, s [STRING]  Not blank string."
    echo "  --list,  -l [ARRAY]   Comma separated list of values."
    echo "  --file,  -f [FILE]    Path to a readable file."
    echo "  --boolean, -b         Boolean flag."
    echo "  --debug, -d           Enables the debug mode."
    echo "  --help, -h            Shows this helper."
    echo ""
    echo "Examples"
    echo "  $_cmd --string 'a simple string' --list 'a,b,c,1,2,3' --file data/sample.txt --boolean --debug command1"
    echo "  $_cmd --string 'a simple string' --list 'a,b,c,1,2,3' --file data/sample.txt --boolean --debug command2"
    echo ""
}

function parse_options () {
    # Default values
    OPTION_BOOLEAN="false"
    OPTION_DEBUG="false"

    POSITIONAL_ARGUMENTS=()
    while [ $# -gt 0 ]; do
        case "$1" in
        --string | -s)
            OPTION_STRING="$2"
            shift
            ;;
        --list | -l)
            OPTION_LIST="$2"
            shift
            ;;
        --file | -f)
            OPTION_FILE="$2"
            shift
            ;;
        --boolean | -b)
            OPTION_BOOLEAN="$2"
            ;;
        --debug | -d)
            OPTION_DEBUG="true"
            ;;
        --help | -h)
            helper
            exit "${SUCCESS}"
            ;;
        --* | -*)
            log_error "Unrecognized option '$1'"
            helper
            exit "${ILLEGAL_ARGUMENT_ERROR}"
            ;;
        *)
            POSITIONAL_ARGUMENTS+=("$1")
            ;;
        esac
        shift
    done

    set -- "${POSITIONAL_ARGUMENTS[@]}"

    ARGUMENT_1=${POSITIONAL_ARGUMENTS[1]}
    ARGUMENT_2=${POSITIONAL_ARGUMENTS[2]}

    if [[ -n "$OPTION_STRING" && "$OPTION_STRING" =~ $BLANK_STRING ]]; then
        log_error "Cannot read blank string: $OPTION_STRING"
        helper
        exit "${ILLEGAL_ARGUMENT_ERROR}"
    fi

    if [[ -n "$OPTION_LIST" && ! "$OPTION_LIST" =~ $COMMA_SEPARATED_LIST ]]; then
        log_error "Cannot parse list: $OPTION_LIST"
        helper
        exit "${ILLEGAL_ARGUMENT_ERROR}"
    fi

    if [[ -n "$OPTION_FILE" && ! -r "$OPTION_FILE" ]]; then
        log_error "Cannot read file: $OPTION_FILE"
        helper
        exit "${ILLEGAL_ARGUMENT_ERROR}"
    fi
}

function print_options() {
    log_debug "OPTION_STRING=$OPTION_STRING"
    log_debug "OPTION_LIST=$OPTION_LIST"
    log_debug "OPTION_FILE=$OPTION_FILE"
    log_debug "OPTION_BOOLEAN=$OPTION_BOOLEAN"
    log_debug "OPTION_DEBUG=$OPTION_DEBUG"
    log_debug "ARGUMENT_1=$ARGUMENT_1"
    log_debug "ARGUMENT_2=$ARGUMENT_2"
}

function execute_function () {
    log_info  "This is an info message"
    log_error "This is an error message"
    log_warn  "This is a warning message"
    log_debug "This is a debug message"
}

function main() {
    parse_options "$@"

    [[ $OPTION_DEBUG == "true" ]] && print_options

    execute_function
}

main "$@"
