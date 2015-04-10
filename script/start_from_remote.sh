#!/usr/bin/env bash
rm -rf tmp
mkdir tmp
cd tmp
contracto start git@github.com:kv109/contracto_sample-contract.git
curl 0.0.0.0:54321/users
curl 0.0.0.0:54321/users/1
curl 0.0.0.0:54321/users/2
contracto stop
cd ..
rm -rf tmp
