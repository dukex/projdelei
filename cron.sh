#!/bin/bash
cd /var/local/apps/projdelei && rake scraper:run && cd /var/local/apps/projdelei && rake twitter:update
