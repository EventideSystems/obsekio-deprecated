# frozen_string_literal: true

# Basic metadata for a creative work
# @see https://schema.org/CreativeWork
# @example
#   {
#     "@context": "https://schema.org",
#     "@type": "CreativeWork",
#     "name": "My Creative Work",
#     "description": "A description of my creative work",
#     "author": {
#       "@type": "Person",
#       "name": "My Name"
#     }
#   }

# NOTE: This is a simple implementation of a CreativeWork type. It is not a complete
# implementation of the CreativeWork schema. You may need to extend this type to
# include additional properties as needed. It's only here as an example of using custom types.
#
# We will provide a more complete implementation of the CreativeWork or other schema.org schemas later.
class CreativeWorkType < ActiveRecord::Type::Value
  def type
    :creative_work
  end

  def cast(value)
    return if value.nil?

    data = value.is_a?(Hash) ? value : JSON.parse(value)

    data.tap do |creative_work|
      creative_work[:@context] = 'https://schema.org' unless creative_work[:@context]
      creative_work[:@type] = 'CreativeWork' unless creative_work[:@type]
    end
  end

  def serialize(value)
    return if value.nil?

    value.to_json
  end
end
