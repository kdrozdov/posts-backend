class Api::V1::UsersController < ApplicationController
  def index
    render json: users
  end

  private

  def users
    @users ||= User.all
  end
end
