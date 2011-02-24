#!/bin/bash
cd /var/local/apps/projdelei && bundle exec rake scraper:run && cd /var/local/apps/projdelei && rake twitter:update
