class ReviewsController < ApplicationController
    get '/reviews' do 
        if !logged_in?
            redirect "/login"
        elsif  @user.is_admin = current_user
            @reviews =Review.all
        else
            @user = current_user
            @reviews = Review.all.select { |review| review.user_id == @user.id } 
            erb :'/reviews/index'
        end 
    end

    get '/reviews/new' do 
        if !logged_in?
            redirect "/login"
        else 
            @course = Courses.all
            erb :'/reviews/new'
        end
    end
    
    post '/reviews' do 
        if !logged_in?
            redirect "/login"
        else 
            @user = current_user
            if (params[:user][:book_id] != nil)
                if !(params[:user][:review].empty?)
                    @book = Book.find_by_id(params[:user][:book_id][0].to_i)
                    @review = Review.create(user_id: @user.id, book_id: @book.id, text: params[:user][:review])
                    redirect "/reviews/#{@review.id}"
                elsif (params[:user][:review].empty?)
                    redirect "/reviews/new"
                end 
            end
        end 
    end
    
    get '/reviews/:id' do 
        #make sure every controller action verifies if there's a user logged in 
        if !logged_in?
            redirect "/login"
        else 
            @review = Review.find_by_id(params[:id])
            erb :'reviews/show'
        end 
    end

    get '/reviews/:id/edit' do 
        if !logged_in?
            redirect "/login"
        else
            @review = Review.find_by_id(params[:id])
            if @review == nil
                redirect 'users/user_home'
            elsif authorized?(@review)
                erb :'/reviews/edit'
            else 
                redirect '/logout'
            end 
        end 
    end

    patch '/reviews/:id' do 
        if !logged_in?
            redirect "/login"
        else 
            @user = current_user
            @review = Review.find_by_id(params[:id])
            @review.text = params[:new_review]
            @review.save
            redirect to "/reviews/#{@review.id}"
        end 
    end

    delete '/reviews/:id' do 
        @review = Review.find_by_id(params[:id])
        @user = current_user
        if @user.id == @review.user_id
            @review.delete
            redirect '/users/user_home'
        else 
            redirect '/logout'
        end 
    end
end