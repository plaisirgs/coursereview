
class UsersController < ApplicationController 
    get '/users/user_dashboard' do
        if !logged_in?
            redirect "/login"
        elsif @user.is_admin = current_user
            erb :"/users/admin_dashboard"
        else
            @user = current_user
            erb :"/users/user_dashboard"
        end 
    end
end
