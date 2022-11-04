#!/bin/sh


if [ "$(uname)" == "Darwin" ]; then
    # TODO: install python for Mac OS X platform
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # TODO: install python for GNU/Linux platform
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # TODO: install python for 32 bits Windows NT platform
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # TODO: install python for 64 bits Windows NT platform
fi
