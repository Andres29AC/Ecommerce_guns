class UsersController < ApplicationController
  #Aqui como test estoy saltando la protección de la página
  #skip_before_action :protect_pages, only: :show
  def show
    @user = User.find_by!(username: params[:username])
    @pagy, @productos = pagy_countless(FindProducts.new.call({ user_id: @user.id }).load_async, items: 4)
  end
end
