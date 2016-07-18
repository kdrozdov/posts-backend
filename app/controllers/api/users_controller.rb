class Api::UsersController < ApplicationController
  # GET /api/users
  def index
    render json: users
  end

  private

  def users
    @users ||= User.all
  end
end
