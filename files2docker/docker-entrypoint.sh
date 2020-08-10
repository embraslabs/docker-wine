#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_GREEN='\033[1;32m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';

print() {
  echo -e "${COLOR_YELLOW}$@${COLOR_CLEAN}"
}

print "================================="
print "Criando DISPLAY"
print "Xvfb :0     -screen 0 1024x768x16 &"
print "================================="
Xvfb :0     -screen 0 1024x768x16 &

wineboot

if [ $# -eq 0 ]; then
	exec /bin/bash
else
	echo -e "${COLOR_GREEN}exec command => $@ ${COLOR_CLEAN}"
	exec "$@"
fi