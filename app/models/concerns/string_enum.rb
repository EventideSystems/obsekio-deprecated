# frozen_string_literal: true

# Define the list of string-based enumerations for a model.
module StringEnum
  extend ActiveSupport::Concern

  class_methods do
    # Define the list of status enumerations for a model.
    # @param field [Symbol] the field to define the enum for
    # @param options [Array<Symbol>] the list of possible values for the enum
    # @param default [Symbol] the default value for the enum (optional)
    #
    # @example
    #   string_enum status: %w[active inactive], default: 'inactive'
    def string_enum(field, options, default: nil)
      enum field => options.map(&:to_sym).index_with(&:to_s)

      return if default.blank?

      after_initialize default_value_method(field, default)
    end

    private

    def default_value_method(field, default)
      define_method "default_#{field}" do
        self[field] = default if self[field].nil? && new_record?
      end
    end
  end
end
