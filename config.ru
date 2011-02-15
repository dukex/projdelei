#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'

Bundler.require

require File.expand_path 'app'

run Sinatra::Application

