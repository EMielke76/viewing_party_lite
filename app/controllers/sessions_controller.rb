class SessionsController < ApplicationController
  before_action :authentication_station, only: [:create]

  def new
  end

  def create
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/dashboard', notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path, notice: 'Logged out'
  end

  private
  def authentication_station
    @user = User.find_by(email: params[:email])
  end
end
