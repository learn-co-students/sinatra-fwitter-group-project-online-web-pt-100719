class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = User.find_by_id(session[:user_id])
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end 

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
            redirect "/tweets/#{tweet.id}"
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in?
            erb :'/tweets/edit_tweet'
        else
            redirect '/login'
        end
    end
    
    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in?
            if @tweet.user_id == current_user.id && !params[:content].empty?
                @tweet.update(:content => params[:content])
            else
                redirect "/tweets/#{@tweet.id}/edit"
            end
        else
            redirect '/login'
        end
               
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in?
            if @tweet.user_id == current_user.id
                @tweet.delete
            else
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect '/login'
        end
    end

end
