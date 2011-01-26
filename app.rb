lib_dir = File.expand_path('lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)


require 'models'

configure do
  set :app_file, __FILE__
  set :haml, {:format => :html5 }
end

get "/" do
end
