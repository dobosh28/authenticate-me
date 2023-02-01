class Api::SessionsController < ApplicationController
  def show
    @user = current_user
    if @user
      render 'api/users/show'
    else
      render json: { user: nil }
    end
  end

  def create
    @user = User.find_by_credentials(params[:credential], params[:password])

    if @user
      login!(@user)
      render 'api/users/show'
    else
      render json: { errors: ["the provided credentials were invalid"] }, status: 401
    end
  end

  def destroy
    if logged_in?
      logout!
      render json: { message: "success" }
    end
  end
end
