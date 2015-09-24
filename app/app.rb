require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  set :session_secret, 'super secret'

  get '/' do
    redirect '/links'
  end

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

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email:                 params[:email],
                        password:              params[:password],
                        password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    elsif @user.email.empty?
      flash.now[:errors] = @user.errors.full_messages
      flash.now[:no_email] = "You must enter an email address."
    else
      flash.now[:errors] = @user.errors.full_messages
    end
      erb :'users/new'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
    def full_messages
      "You must enter an email address"
      "Password does not match the confirmation"
      "Email is already taken"
    end
  end

    # start the server if ruby file executed directly
  run! if app_file == $0


end
