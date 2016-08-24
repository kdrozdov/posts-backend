module Sortable
  extend ActiveSupport::Concern
  AVAILABLE_DIRECTIONS = %w(asc desc).freeze

  class_methods do
    def apply_sort(field, direction)
      result = all
      field ||= 'created_at'
      direction ||= 'desc'

      return result unless sortable_columns.include?(field)
      return result unless AVAILABLE_DIRECTIONS.include?(direction)
      result.order("#{field} #{direction}")
    end

    def sortable_columns
      %w(created_at)
    end
  end
end
