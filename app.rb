lib_dir = File.expand_path('lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)


require 'models'

set :logging, :true

configure do
  Log = Logger.new("log/sinatra.log")
  Log.level  = Logger::INFO 
  
  @@config = YAML.load_file("config.yml") rescue nil || {}
end

get "/" do
end

get '/' do
  haml :index
end

get '/scrap' do
  
end

helpers do    
  def exist?(options = {})
    @data = ProjectOfLaw.first(:id => options[:id]) 
    if @data
      return true
    else
      return false
    end
  end
end