#!/bin/bash
ver=$(grep " taVersion" ./src/utaversion.pas | cut -d "'" -f2)
rev=$(grep " taRevision" ./src/tarevision.inc | cut -d "'" -f2)
git status
git add .
git status
#git commit -m "v0.1.0.67"
git commit -m "v$ver.$rev"
git status
git push

#create file ~/.netrc
#machine github.com
#       login mylogin
#       password mypassword
