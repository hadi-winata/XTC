class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

	def index
    @users = User.paginate(page: params[:page], :per_page => 15)
  end

  def show
   	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 15)
 	end

 	def new 
 		@user = User.new
 	end

 	def create
   	@user = User.new(user_params)  
    if @user.save
      sign_in @user
      #UserMailer.welcome_email(@user).deliver
     	flash[:success] = "Selamat datang di XTC"
     	#redirect_to @user
      redirect_to root_url
    else
      	#render 'new'
        redirect_to root_url, :flash => { :error => "Ulangi ada kesalahan !" }
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profil telah diperbaharui"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Anggota telah dihapus"
    redirect_to users_url
  end

  def following
    @title = "Mengikuti"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Pengikut"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Silahkan masuk" 
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
