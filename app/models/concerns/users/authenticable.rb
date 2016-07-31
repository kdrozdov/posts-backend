module Users
  module Authenticable
    extend ActiveSupport::Concern

    included do
      attr_accessor :password_confirmation
      has_secure_password

      validates :password, length: { minimum: 3 }, if: -> { password_changed? }
      validates :password, confirmation: true, if: -> { password_changed? }
      validates :password_confirmation, presence: true,
                                        if: -> { password_changed? }
    end

    class_methods do
      def from_token_request(request)
        phone = request.params['auth'] && request.params['auth']['phone']
        find_by(phone: phone)
      end

      def from_token_payload(payload)
        find(payload['sub'])
      end
    end

    def to_token
      ::Knock::AuthToken.new(payload: { sub: id }).token
    end

    private

    def password_changed?
      new_record? || changes[:password_digest]
    end
  end
end
