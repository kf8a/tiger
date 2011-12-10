require 'sinatra'

class DataServer < Sinatra::Base
  get '/' do
    "1,3\n"
  end
  post '/' do
    p request.body.read
  end
end
