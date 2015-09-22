require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  # get '/' do
  #   erb :index
  # end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/create_links'
  end

  post '/links' do
    # session[:url] = params[:url]
    # session[:title] = params[:title]
    Link.create(url: params[:url], title: params[:title])
    redirect '/links'
  end

  # get '/links/' do
  #
  # end


    # start the server if ruby file executed directly
  run! if app_file == $0


end
