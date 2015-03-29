#!/usr/bin/env bash
rm -rf tmp
mkdir tmp
cd tmp
contracto start https://github.com/kv109/cdc-sample-contract.git
curl 0.0.0.0:54321/users
curl 0.0.0.0:54321/users/1
curl 0.0.0.0:54321/users/2
contracto stop
cd ..
rm -rf tmp
