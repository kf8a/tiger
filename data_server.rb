require 'sinatra'

class DataServer < Sinatra::Base
  enable :sessions

  @@desired = ""
  @@access = []

  get '/' do
    @@access << request.host
    @@desired.empty? ? "1\n" : @@desired
  end

  get '/redirect' do
    @@access << request.host
    redirect to('/')
  end

  get '/status/:id' do
    status params[:id]
    id
  end

  post '/' do 
    @@desired = request.body.read
  end

  get '/accessed_by' do
    access = @@access.dup
    @@access = []
    access
  end
end
