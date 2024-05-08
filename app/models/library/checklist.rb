# frozen_string_literal: true

module Library
  # Checklist belonging to the library
  class Checklist < ApplicationRecord
    has_logidze

    belongs_to :created_by, class_name: 'User', optional: true

    string_enum :status, %i[draft published archived], default: :draft

    # Mapping of basic metadata. The actual metadata is stored in the metadata column
    #
    # We assume that the metadata conforms to the schema.org CreativeWork type
    # @see https://schema.org/CreativeWork
    #
    # These accessors / attributes are only for convenience when working with the metadata
    # in forms. It may be better to use a form object or delegate to a presenter object
    store_accessor :metadata, :name, :description, :author, :license
    attribute :author, :jsonb, default: { '@type': 'Person', name: '' }
    store_accessor :author, :name, prefix: true

    validates :title, presence: true
  end
end
