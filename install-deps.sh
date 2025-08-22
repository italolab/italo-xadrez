#!/bin/bash

install() {
    apt install libsdl2-2.0-0 -y
    apt install libsdl2-mixer-2.0-0 -y
    apt install libsdl2-image-2.0-0 -y
    apt install libsdl2-ttf-2.0-0 -y
    echo "SDL2 instalado."
}

install_dev() {
    apt install libsdl2-dev -y
    apt install libsdl2-mixer-dev -y
    apt install libsdl2-image-dev -y
    apt install libsdl2-ttf-dev -y
    echo "SDL2 instalado."
}

remove() {
    apt remove libsdl2-2.0-0 -y
    apt autoremove libsdl2-2.0-0 -y
    echo "SDL2 removido."
}

remove_dev() {
    apt remove libsdl2-dev -y
    apt autoremove libsdl2-dev -y
    echo "SDL2 removido."
}

if command -v apt &> /dev/null; then
    if [ "$#" -gt "0" ]; then        
        case $1 in
            "install")
                if [ "$#" -gt "1" ]; then
                    case $2 in
                        "dev")
                            install_dev
                            ;;
                        *)
                            echo "O segundo parametro deve nao ser informado ou ser dev"
                        ;;
                    esac
                else
                    install
                fi
                ;;
            "remove")
                if [ "$#" -gt "1" ]; then
                    case $2 in
                        "dev")
                            remove_dev
                            ;;
                        *)
                            echo "O segundo parametro deve nao ser informado ou ser dev"
                        ;;
                    esac
                else
                    remove
                fi
                ;;
            *)
                echo "O primeiro argumento deve ser install ou remove"
                ;;
        esac
    else
        install_dev;
    fi
else
    echo "Esse script so funciona em sistemas ubuntu ou que têm o apt instalado."
fi
