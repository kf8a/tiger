require 'sinatra'

class DataServer < Sinatra::Base
  enable :sessions

  @@desired = ""
  @@sleep = 0

  get '/' do
    sleep @@sleep
    @@desired.empty? ? "1\n" : @@desired
  end
  post '/' do 
    @@desired = request.body.read
  end

  post '/sleep' do
    @@sleep = request.body.read.to_i
  end
end
