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

  def tweet(pl, url, txt)
    url_min = shorten url
    #return "#{url_min} #{txt[0,105]}... #{pl}".gsub( /[\n\r]/,' ').gsub('  ',' ')
  end

  def shorten(url)
    Log.info @@config
    Log.info "User: #{@@config['user_bitly']}"
    Log.info "Key: #{@@config['key_bitly']}"
    Log.info "#{url}"
    Log.info "========="
    #new_url = open("http://api.j.mp/v3/shorten?login=#{@@config['user_bitly']}&apiKey=#{@@config['key_bitly']}&longUrl=#{url}&format=txt").read
    #return new_url
  end
end


