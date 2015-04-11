#!/usr/bin/env bash
for path in users users/1 users/2 users/1/posts users/2/posts; do curl 0.0.0.0:54321/$path; done