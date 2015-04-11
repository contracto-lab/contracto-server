#!/usr/bin/env bash
rm -rf tmp
mkdir tmp
cd tmp
contracto init
contracto start
../send_test_requests.sh
contracto stop
contracto start
contracto stop
cd ..
rm -rf tmp