require 'sinatra'

class DataServer < Sinatra::Base
  enable :sessions

  @@desired = ""
  @@sleep = 0
  @@access = []

  get '/' do
    @@access << request.host
    sleep @@sleep
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

  post '/sleep' do
    @@sleep = request.body.read.to_i
  end

  get '/accessed_by' do
    access = @@access.dup
    @@access = []
    access
  end
end
