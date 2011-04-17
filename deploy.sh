#!/bin/bash
git push origin master
if [ $1 == "install" ]
  then
  ssh -A deploy@67.23.242.87 'mkdir /var/local/apps/projdelei && cd /var/local/apps/projdelei && git init . && git remote add origin git@github.com:emersonvinicius/projdelei.git'
fi

ssh -A deploy@67.23.242.87 'cd /var/local/apps/projdelei && git pull origin master && bundle install --path ~/.bundle --without development test cucumber environment=production'
