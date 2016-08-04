class Api::V1::Users::AuthTokensController < ::Knock::AuthTokenController
  private

  def entity_class
    User
  end
end
