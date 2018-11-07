#!/bin/bash
gcc xxx1.c  -o xxx1  `pkg-config --cflags --libs libmodbus`
gcc xxx2.c  -o xxx2  `pkg-config --cflags --libs libmodbus`
