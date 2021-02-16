class SessionsController < Devise::SessionsController
  after_action :store_location

  def store_location
    session[:previous_url] = request.fullpath 
  end

  def new_guest
    user = User.guest
    sign_in user
    redirect_to session[:previous_url], notice: 'ゲストユーザーとしてログインしました。'
  end
end