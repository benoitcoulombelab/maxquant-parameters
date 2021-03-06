#!/bin/bash

VENV="$HOME/maxquant-venv"
BASH="$VENV"/bash
MAXQUANT="$VENV"/maxquant
MAXQUANT_BASH="$MAXQUANT"/bash
EMAIL="$JOB_MAIL"

if [ "$1" == "clean" ]
then
    echo "Removing python virtual environment at $VENV"
    rm -R "$VENV"
    exit 0
fi
if [[ ! "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]
then
    echo "Could not find your email address. Did you run configure.sh?"
    exit 1
fi
if [ ! -d "$VENV" ]
then
    echo "Creating python virtual environment at $VENV"
    python3 -m venv "$VENV"
fi
echo "Updating python libraries"
pip uninstall -y MaxquantTools
pip install git+https://github.com/benoitcoulombelab/maxquant-tools.git
echo "Updating bash scripts"
rm -R "$BASH"
mkdir "$BASH"
git clone --depth 1 https://github.com/benoitcoulombelab/maxquant-tools.git "$MAXQUANT"
cp "$MAXQUANT_BASH"/*.sh "$BASH"
find "$BASH" -type f -name "*.sh" -exec sed -i "s/christian\.poitras@ircm\.qc\.ca/$EMAIL/g" {} \;
rm -Rf "$MAXQUANT"
