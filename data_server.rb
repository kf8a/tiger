require 'sinatra'

class DataServer < Sinatra::Base
  get '/' do
    "1\n"
  end
  post '/' do
    p request
  end
end
