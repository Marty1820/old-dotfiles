#!/bin/sh

# Original location of files:
# https://gitlab.com/phoneybadger/pokemon-colorscripts

PROGRAM_DIR="$HOME/.fun/pokemon"
# directory where all the art files exist
POKEART_DIR="$PROGRAM_DIR/colorscripts"
# formatting for the help strings

_help(){
    #Function that prints out the help text

    echo "Description: CLI utility to print out unicode image of a pokemon in your shell"
    echo ""
    echo "Usage: pokemon-colorscripts [OPTION] [POKEMON NAME]"
    printf "  %-20s\t%-54s\n" \
        "-h, --help, help" "Print this help." \
        "-l, --list, list" "Print list of all pokemon"\
        "-r, --random, random" "Show a random pokemon"\
        "-n, --name" "Select pokemon by name. 
        Generally spelled like in the games. 
        Some exceptions are nidoran-f,nidoran-m,mr-mime,farfetchd,flabebe type-null etc. 
        grep the output of --list if in doubt"
    echo "Example: 'pokemon-colorscripts --name pikachu'"
}

_show_random_pokemon(){
    #selecting a random art file from the whole set

    # total number of art files present
    NUM_ART=$(find "$POKEART_DIR"|wc -l| xargs)
    # getting a random index from 0-NUM_ART. (using gshuf instead of $RANDOM for POSIX compliance)
    random_index=$(shuf -i 1-"$NUM_ART" -n 1)
    random_pokemon=$(sed "$random_index"'q;d' "$PROGRAM_DIR/nameslist.txt")
    echo "$random_pokemon"

    # print out the pokemon art for the pokemon
    cat "$POKEART_DIR/$random_pokemon.txt"
}

_show_pokemon_by_name(){
    pokemon_name=$1
    echo "$pokemon_name"
    # Error handling. Can't think of a better way to do it
    cat "$POKEART_DIR/$pokemon_name.txt" 2>/dev/null || echo "Invalid pokemon"
}

_list_pokemon_names(){
    less < "$PROGRAM_DIR/nameslist.txt"
}

# Handling command line arguments
case "$#" in
    0)
        # display help if no arguments are given
        _help
        ;;
    1)
        # Check flag and show appropriate output
        case $1 in
            -h | --help | help)
                _help
                ;;
            -r | --random | random)
                _show_random_pokemon
                ;;
            -l | --list | list)
                _list_pokemon_names
                ;;
            *)
                echo "Input error."
                exit 1
                ;;
        esac
        ;;

    2)
        if [ "$1" = '-n' ]||[ "$1" = '--name' ]||[ "$1" = 'name' ]; then
            _show_pokemon_by_name "$2"
        else
            echo "Input error"
            exit 1
        fi
        ;;
    *)
        echo "Input error, too many arguments."
        exit 1
        ;;
esac
