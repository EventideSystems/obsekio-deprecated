# frozen_string_literal: true

# Non-ActiveRecord model to represent an additional state for a radio data entry
class DataEntryRadioAdditionalState
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :text, :color

  def attributes
    {
      text:, color:
    }
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
