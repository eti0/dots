#!/bin/sh

clear

weather -m -q LFBD | grep --color=always -e Temperature -e Wind -e Relative

