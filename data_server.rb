require 'sinatra'

class DataServer < Sinatra::Base
  get '/' do
    "1,2,3\n"
  end
end
