require 'sinatra'

class DataServer < Sinatra::Base
  enable :sessions

  @@desired = nil

  get '/' do
    @@desired || "1\n"
  end
  post '/' do 
    @@desired = request.body.read
  end
end
