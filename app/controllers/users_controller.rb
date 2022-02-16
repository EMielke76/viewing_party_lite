class UsersController < ApplicationController
  before_action :registration_guardhouse,  only: [:create]

  def show
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      flash[:success] = 'Account Successfully Created!'
      session[:user_id] = new_user.id
      redirect_to user_dashboard_path(new_user.id)
    else
      flash[:error] = 'Email address is blank/already in use.'
      redirect_to register_path
    end
  end

  def discover
    @user = User.find(params[:user_id])
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
    end
end
