#!/usr/bin/env bash
rm -rf tmp
mkdir tmp
cd tmp
contracto start git@github.com:kv109/contracto_sample-contract.git
../send_test_requests.sh
contracto stop
contracto start
contracto stop
cd ..
rm -rf tmp
