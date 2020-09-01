#
## utility functions ##

is_wsl() {
    if grep -qE "(Microsoft|microsoft|WSL)" /proc/version &> /dev/null ; then
        true
    else
        false
    fi
}

is_program_installed() {
    if command -v $1 >/dev/null 2>&1; then
        true
    else
        false
    fi
}

is_not_mac() {
    if [[ $(uname) != "Darwin" ]]; then
        true
    else
        false
    fi
}

function is_linux() {
    local SYSTEM_NAME="$(expr substr $(uname -s) 1 5)"

    if [ "$SYSTEM_NAME" = "Linux" ] && ! is_wsl; then
        true
    else
        false
    fi
}

function is_windows() {
    local SYSTEM_NAME="$(expr substr $(uname -s) 1 10)"

    if [ "$SYSTEM_NAME" = "MINGW64_NT" ]; then
        true
    elif [ "$SYSTEM_NAME" = "MINGW32_NT" ]; then
        true
    else
        false
    fi
}
