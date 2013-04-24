require 'bundler'
Bundler.require

lib_dir = File.expand_path('../lib', __FILE__)
$:.unshift lib_dir unless $:.include?(lib_dir)

require 'models'
require 'grape_hack'

module ProjDeLei
  class API < Grape::API
    format :json

    resource :laws do
      get do
        @laws = LawProject.all(order: [ :id.desc ])
        @laws.to_json(exclude: [:id, :was_shared])
      end
    end
  end
end
