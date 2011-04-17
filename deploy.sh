#!/bin/bash
git push origin master
ssh -A deploy@67.23.242.87 'cd /var/local/apps/projdelei && git pull origin master && bundle install --path ~/.bundle --without development test cucumber environment=production'
