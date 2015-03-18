#!/usr/bin/env bash
rm -rf tmp
mkdir tmp
cd tmp
contracto start https://github.com/kv109/cdc-sample-contract.git
contracto stop
cd ..
rm -rf tmp