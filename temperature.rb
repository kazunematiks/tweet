#!/usr/bin/env ruby

require 'bundler'
Bundler.require
Dotenv.load

# twitter settings
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

# Arduino settings
arduino = ArduinoFirmata.connect ENV['CONNECTION_PATH']
puts "firmata version #{arduino.version}"

loop do
  arduino.digital_write 13, true
  temp = arduino.analog_read(1)*100*5/1024
  puts temp
  time = Time.now.strftime("%H:%M")
  client.update("室温は#{temp}度です at #{time}")
  sleep 1800
end
