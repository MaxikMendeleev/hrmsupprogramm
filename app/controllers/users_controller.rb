class UsersController < ApplicationController

  before_filter :authenticate_user!
  # user_signed_in?
  def show
    @user = User.find(current_user.id)
    # @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удален"
    redirect_to users_url
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Ваш профиль обновлен"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Добро пожаловать!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :password,
                                 :password_confirmation)
  end

end
