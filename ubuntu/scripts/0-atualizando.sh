#!/bin/bash

updateSystem () {
    echo -e "========= Executando # Instalando ferramentas ==========="
    sudo apt update
    sudo apt install -y \
                    unzip \
                    python3 \
                    git
}

updateSystem