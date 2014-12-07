#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

require 'bundler'
Bundler.require
Dotenv.load

uri = URI.parse('http://api.openweathermap.org/data/2.5/weather?units=metric&q=Tokyo,jp')
json = Net::HTTP.get(uri)
result = JSON.parse(json)

temp = result['main']['temp']

puts temp

