class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/create_user'
        end
    end

    post '/signup' do
        user = User.new(params)
        
        if user.save
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else 
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    get '/users/:id' do
        @user_tweets = Tweet.all.collect{|tweet| tweet.user_id == current_user.id}    
    end 

end
