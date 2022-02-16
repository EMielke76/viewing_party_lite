class UsersController < ApplicationController
  before_action :registration_guardhouse,  only: [:create]
  before_action :authentication_station, only: [:login_user]

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

  def login_form
  end

  def login_user
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_dashboard_path(@user), notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :login_form
    end
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

    def authentication_station
      @user = User.find_by(email: params[:email])
    end
end
