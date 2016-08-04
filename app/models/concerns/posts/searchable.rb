module Posts
  module Searchable
    extend ActiveSupport::Concern

    SEARCH_PARAMS = {
      against: :title,
      using: {
        tsearch: {
          prefix: true,
          dictionary: 'simple'
        }
      }
    }.freeze

    included do
      include PgSearch
      pg_search_scope :search_by_title, SEARCH_PARAMS
    end

    class_methods do
      def search(query)
        return all unless query.present?
        search_by_title(query)
      end
    end
  end
end
