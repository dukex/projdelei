require File.dirname(__FILE__) + '/spec_helper'

describe Sinatra::Application do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

end

