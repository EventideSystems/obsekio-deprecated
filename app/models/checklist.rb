# frozen_string_literal: true

# Base class for checklist models.
# NOTE: This is an abstract class and should not be used directly.
#
# @abstract
# @see Library::Checklist
# @see Templates::Checklist
class Checklist < ApplicationRecord
  include StringEnum
  has_markdown :content
end
