class Api::SessionsController < ApplicationController
  def show
    @user = current_user
    if @user
      render json: { user: current_user.as_json }
    else
      render json: { user: nil }
    end
  end

  def create
    @user = User.find_by_credentials(params[:credentials], params[:password])

    if @user
      login!(@user)
      render json: { user: user }
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
