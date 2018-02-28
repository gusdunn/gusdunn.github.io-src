#!/usr/bin/bash -ex

cd site/public
git add .
git commit -m "rebuilt site $(date)"
git push origin master