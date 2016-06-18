require './config/environment'
require 'rack-flash' 

class ApplicationController < Sinatra::Base
  ADJECTIVES = ["sexy", "strong", "powerful", "courageous", "hardworking", "beautiful", "intimidating", "classy", "foxy", "studly", "tenacious"]
  NOUNS = ["beast", "devil", "human", "athlete", "specimen", "fighter", "stud", "tamale"]

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  get '/' do
    @home = true
    if !session[:id] 
      redirect to '/login'
    end
    @user = User.find(session[:id])
    @adjective = ADJECTIVES.sample
    @noun = NOUNS.sample
    @workouts = Workout.all
    erb :index
  end

  get '/signup' do 
    if session[:id]
      redirect to '/'
    else
      erb :signup
    end
  end

  post '/signup' do 
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect to '/'
    else
      flash[:message] = "Name, email and password are required"
      redirect to '/signup'
    end
  end

  get '/login' do 
    if session[:id]
      redirect to '/'
    end
    erb :login
  end

  post '/login' do 
    if @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
      session[:id] = @user.id
      redirect to '/'
    else
      flash[:message] = "Invalid username or password"
      redirect to '/login'
    end
  end

  get '/users/:slug' do 
    redirect to '/login' if !session[:id]

    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/workouts' do 
    @workout = true
    redirect to '/login' if !session[:id]

    @workouts = Workout.all
    @exercises = Exercise.all
    erb :'/workouts/index'
  end

  post '/workouts' do 
    redirect to '/login' if !session[:id] 

    flash[:message] = nil 
    @user = User.find(session[:id])
    @user.workouts << Workout.create(params[:workout]) 
    redirect to '/workouts'
  end
  
  get '/workouts/find' do 
    @items = Item.all
    erb :'/workouts/find' 
  end

  post '/workouts/find' do 
    @workouts = Workout.all
    @items = []

    if params[:item_ids] 
      params[:item_ids].each do |item|
        @items << Item.find(item)
      end
    end
    @results = []
    @workouts.each do |workout|
      if (workout.items - @items).empty?
        @results << workout
      end
    end

    @exercises = Exercise.all  
    if @results.empty? 
      flash[:message] = "No workouts found, try adding equipment or create your own workout below"
    end
    @workouts = @results
    erb :'/workouts/index'
  end

  get '/workouts/:id' do 
    redirect to '/login' if !session[:id]
    @workout = Workout.find(params[:id])
    @workouts = Workout.all
    erb :'/workouts/show' 
  end

  get '/workouts/:id/edit' do 
    @workout = Workout.find(params[:id])
    @exercises = Exercise.all
    @items = Item.all
    if session[:id] != @workout.user_id
      redirect to "/workouts/#{params[:id]}"
    end
    erb :'/workouts/edit' 
  end

  patch '/workouts/:id' do 
    @workout = Workout.find(params[:id])
    @workout.update(params[:workout])
    redirect to "/workouts/#{params[:id]}" 
  end

  get '/exercises' do 
    @exercise = true
    redirect to '/login' if !session[:id]

    @exercises = Exercise.all
    @items = Item.all
    erb :'/exercises/index'
  end

  post '/exercises' do 
    redirect to '/login' if !session[:id] 

    @user = User.find(session[:id])
    @exercise = Exercise.create(params[:exercise]) 
    if params[:item_name] != ""
      @items = params[:item_name].split(",").collect {|x| x.strip || x }
      @items.each do |item|
        @exercise.items << Item.create(name: item)
      end
    end
    @user.exercises << @exercise
    redirect to '/exercises'
  end

  get '/exercises/:id' do 
    @exercises = true
    redirect to '/login' if !session[:id]
    @exercise = Exercise.find(params[:id])
    erb :'/exercises/show'
  end

  get '/exercises/:id/edit' do 
    @exercises = true
    @exercise = Exercise.find(params[:id])
    @items = Item.all
    if session[:id] != @exercise.user_id
      redirect to "/exercises/#{params[:id]}"
    end
    erb :'/exercises/edit' 
  end

  patch '/exercises/:id' do 
    @exercise = Exercise.find(params[:id]) 
    @exercise.update(params[:exercise])
    redirect to "/exercises/#{params[:id]}"
  end

  get '/logout' do 
    if session[:id] 
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
