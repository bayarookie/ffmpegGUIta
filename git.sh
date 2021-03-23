#!/bin/bash
### create file ~/.netrc
#machine gitlab.com
#       login mylogin
#       password mypassword
### git config
#git config --global user.email "name@server"
#git config --global user.name "name"

if [ -t 0 ] ; then
git status
echo ---------------------------------------------------------------------------
read -r -p "git add . > Run? [Y/n]" yesno
yesno=${yesno,,}
if [[ $yesno =~ ^(yes|y| ) ]] | [ -z $yesno ]; then
  git add .
  echo ---------------------------------------------------------------------------
  git status
  echo ---------------------------------------------------------------------------
  ver=$(grep " taVersion" ./src/utaversion.pas | cut -d "'" -f2)
  rev=$(grep " taRevision" ./src/tarevision.inc | cut -d "'" -f2)
  read -r -p "git commit -m v$ver.$rev > Run? [Y/n]" yesno
  yesno=${yesno,,}
  if [[ $yesno =~ ^(yes|y| ) ]] | [ -z $yesno ]; then
    git commit -m "v$ver.$rev"
    echo ---------------------------------------------------------------------------
    git status
    echo ---------------------------------------------------------------------------
    read -r -p "git push > Run? [Y/n]" yesno
    yesno=${yesno,,}
    if [[ $yesno =~ ^(yes|y| ) ]] | [ -z $yesno ]; then
      git push
    fi
  fi
fi
else
  /usr/bin/kdialog --title="Не пойдёт" --msgbox="запускать в терминале"
fi
