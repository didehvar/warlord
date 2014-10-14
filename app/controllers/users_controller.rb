class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render json: @user, only: [:username]
  end

  def create
    @user = User.new(user_params)
    if (@user.save)
      render json: { users: @user }, status: :created
    else
      render json: @user.errors.full_messages, status: :bad_request
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end
end
