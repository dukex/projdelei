require File.dirname(__FILE__) + '/spec_helper'

describe Sinatra::Application do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  describe 'test routes' do
    it "should respond to /" do
      get '/'
      last_response.should be_ok
    end

    it "should return 404 status" do
      get '/404'
      last_response.status.should == 404
    end
  end
end
