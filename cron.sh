#!/bin/bash
cd /var/local/apps/projdelei
rake scraper:run >> logs/scraper.log
rake twitter:update >> logs/updater.log
