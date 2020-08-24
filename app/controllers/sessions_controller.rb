class SessionsController < ApplicationController
    get '/signup' do 
        erb :'/sessions/signup'
    end

    post '/signup' do 
        is_admin = params[:email_address].include?("@chp.com") ? true : false
        user = User.new(email_address: params[:email_address], password: params[:password], is_admin: is_admin)
        if user.save
            redirect "/login"
        else 
            erb :"/sessions/error"
        end
    end

    get '/login' do 
        erb :'/sessions/login'
    end

    post '/login' do 
        @user = User.find_by(email_address: params[:email_address])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            erb :"/users/user_dashboard"
        elsif @user.is_admin
            erb :"/users/admin_dashboard"
        else
            erb :"/sessions/error"
        end
    end

    get '/logout' do 
        if logged_in? 
            session.clear 
            @message = "You have been successfully logged out."
            redirect '/'
        else 
            erb :'/sessions/error'
        end 
    end

end