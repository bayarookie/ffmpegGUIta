#!/bin/bash
git status
read -r -p "git add . > Run? [Y/n]" yesno
yesno=${yesno,,}
if [[ $yesno =~ ^(yes|y| ) ]] | [ -z $yesno ]; then
  git add .
  git status
  ver=$(grep " taVersion" ./src/utaversion.pas | cut -d "'" -f2)
  rev=$(grep " taRevision" ./src/tarevision.inc | cut -d "'" -f2)
  read -r -p "git commit -m v$ver.$rev > Run? [Y/n]" yesno
  yesno=${yesno,,}
  if [[ $yesno =~ ^(yes|y| ) ]] | [ -z $yesno ]; then
   #git commit -m "v0.1.0.67"
    git commit -m "v$ver.$rev"
    git status
    read -r -p "git push > Run? [Y/n]" yesno
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
