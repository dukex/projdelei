set :output, "/var/local/apps/projdelei/logs/cron.log"

every 1.hour do
  %w{scraper:run twitter:update}.each do |task|
    command "source ~/.env && cd /var/local/apps/projdelei && bundle exec rake #{task} --silent environment=production"
  end
end
