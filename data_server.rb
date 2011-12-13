require 'sinatra'

class DataServer < Sinatra::Base
  enable :sessions

  @@desired = ""

  get '/' do
    @@desired.empty? ? "1\n" : @@desired
  end
  post '/' do 
    @@desired = request.body.read
  end
end
