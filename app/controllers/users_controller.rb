
class UsersController < ApplicationController 
    get '/users/user_dashboard' do
        if !logged_in?
            redirect "/login"
        else
            @user = current_user
            erb :"/users/user_dashboard"
        end 
    end
end
