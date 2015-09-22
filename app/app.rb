require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/create_links'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title], tag: params[:tag])
    redirect '/links'
  end


    # start the server if ruby file executed directly
  run! if app_file == $0


end
