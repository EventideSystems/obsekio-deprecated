# frozen_string_literal: true

# Non-ActiveRecord model to represent an available state for a checklist item
class ChecklistItemStateDefinition
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :state, :title, :default

  attribute :light_colors, ChecklistItemStateDefinitionColor.new
  attribute :dark_colors, ChecklistItemStateDefinitionColor.new

  # Return the model attributes as a hash. Used for serialization.
  # Only the attributes declared in this method will be saved in database.
  #
  # @return [Hash] The list of attributes used for serialization.
  #
  def attributes
    {
      state:, title:, default:, light_colors:, dark_colors:
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
