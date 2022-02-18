class UsersController < ApplicationController
  before_action :registration_guardhouse,  only: [:create]
  before_action :members_only, only: [:show]
  def show
    current_user
  end

  def new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      flash[:success] = 'Account Successfully Created!'
      session[:user_id] = new_user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Email address is blank/already in use.'
      redirect_to register_path
    end
  end

  def discover
    current_user
  end


  private
    def user_params
      params.permit(:email, :name, :password, :password_confirmation)
    end

    def registration_guardhouse
      if params[:password] != params[:password_confirmation]
        flash[:error] = 'Password does not match!'
        redirect_to register_path
      end
      if params[:name] == ""
        flash[:error] = 'Name cannot be blank'
        redirect_to register_path
      end
    end

    def members_only
      if !current_user
        flash[:message] = 'You must be logged in or registered to perform this action'
        redirect_to root_path
      end
    end
end
