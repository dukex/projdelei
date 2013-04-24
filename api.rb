require 'bundler'
Bundler.require

lib_dir = File.expand_path('../lib', __FILE__)
$:.unshift lib_dir unless $:.include?(lib_dir)

require 'models'
require 'grape_hack'

module ProjDeLei
  class API < Grape::API
  end
end
