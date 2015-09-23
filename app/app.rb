require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/create_links'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title], tag: params[:tags])
    params[:tags] == "" ? params[:tags] = "no_tags" : params[:tags]
    tags_array = params[:tags].split(" ")
    tags_array.each do |word|
      tag = Tag.create(name: word)
      link.tags << tag
      link.save
    end
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    @links.join(" ")
    erb :'links/index'
  end

  get 'users/new' do
    erb :'users/new'
  end

  post '/users' do
    User.create(email: params[:email], password: params[:password])
      session[:user_id] = user.id
    redirect to('/links')
end

    # start the server if ruby file executed directly
  run! if app_file == $0


end
