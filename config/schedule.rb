set :output, "/var/local/apps/projdelei/logs/cron.log"

every 1.hour do
  rake "scraper:run"
  rake "twitter:update"
end
