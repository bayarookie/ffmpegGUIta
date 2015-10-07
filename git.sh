#!/bin/bash
git status
read -r -p "Git Add? [Y/n]" yesno
yesno=${yesno,,}
if [[ $yesno =~ ^(yes|y| ) ]] | [ -z $yesno ]; then
  git add .
  git status
  read -r -p "Git Commit? [Y/n]" yesno
  yesno=${yesno,,}
  if [[ $yesno =~ ^(yes|y| ) ]] | [ -z $yesno ]; then
    ver=$(grep " taVersion" ./src/utaversion.pas | cut -d "'" -f2)
    rev=$(grep " taRevision" ./src/tarevision.inc | cut -d "'" -f2)
   #git commit -m "v0.1.0.67"
    echo "v$ver.$rev"
    git commit -m "v$ver.$rev"
    git status
    read -r -p "Git Push? [Y/n]" yesno
    yesno=${yesno,,}
    if [[ $yesno =~ ^(yes|y| ) ]] | [ -z $yesno ]; then
      git push
    fi
  fi
fi

#create file ~/.netrc
#machine github.com
#       login mylogin
#       password mypassword
