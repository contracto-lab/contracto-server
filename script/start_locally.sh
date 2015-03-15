#!/usr/bin/env bash
rm -rf tmp
mkdir tmp
cd tmp
contracto init
contracto start
contracto stop
cd ..
