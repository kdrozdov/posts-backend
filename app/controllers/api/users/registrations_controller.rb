class Api::Users::RegistrationsController < ::ApplicationController
  def create
    if user.save
      render json: auth_token, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user
    @user ||= User.new(user_params)
  end

  def auth_token
    { jwt: user.to_token }
  end

  def user_params
    permitted_attributes = %i(
      phone
      name
      password
      password_confirmation
    )
    params.require(:user).permit(permitted_attributes)
  end
end
