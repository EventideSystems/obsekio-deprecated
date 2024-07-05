# frozen_string_literal: true

module ContextInstances
  # Tag model
  class Tag < ContextInstance
    store_accessor :data, :name, :color, :description
    attribute :name, :string, default: ''
    attribute :color, :string, default: ''
    attribute :description, :string, default: ''

    validates :name, presence: true
    validate :validate_name_uniqueness

    # Validate the uniqueness of the tag name, scoped to the context
    def validate_name_uniqueness
      return unless Tag.where("data ->> 'name' = ?", data['name']).where.not(id:).where(context:).exists?

      errors.add(:name, 'has already been taken in this context.')
    end
  end
end
