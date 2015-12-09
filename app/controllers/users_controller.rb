class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = :manager
    if @user.save
      flash[:notice] = "Пользователь создан"
      redirect_to users_path
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    parms = user_params
    parms.delete(:password) if parms[:password].blank?
    parms.delete(:password_confirmation) if parms[:password].blank? and parms[:password_confirmation].blank?
    if @user.update_attributes(parms)
      flash[:notice] = "Пользователь обновлен"
      redirect_to users_path
    else
      render action: 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "Пользовтель удален"
      redirect_to users_path
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
