# frozen_string_literal: true

# Base class for all models
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  self.implicit_order_column = 'created_at'
end
