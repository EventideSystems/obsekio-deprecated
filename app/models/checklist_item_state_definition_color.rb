# frozen_string_literal: true

# Non-ActiveRecord model to represent a checklist item state definition color
class ChecklistItemStateDefinitionColor < ActiveRecord::Type::Value
  include ActiveModel::Model

  attr_accessor :dark_colors, :light_colors

  # Return the model attributes as a hash. Used for serialization.
  # Only the attributes declared in this method will be saved in database.
  #
  # @return [Hash] The list of attributes used for serialization.
  #
  def attributes
    {
      dark_colors:, light_colors:
    }
  end

  def assert_valid_value(value)
    value.keys.include?(%w[background text])
  end

  # The equality operator. Used to compare objects and detect
  # if changes have occured.
  #
  # @param [Object] other The object to compare.
  #
  # @return [Boolean] True if the object is equal.
  #
  def ==(other)
    other.is_a?(self.class) && other.attributes == attributes
  end
end
