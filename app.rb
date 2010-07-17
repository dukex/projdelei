lib_dir = File.expand_path('lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)


require 'models'

configure do
  set :app_file, __FILE__
  set :haml, {:format => :html5 }
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