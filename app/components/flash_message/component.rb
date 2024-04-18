# frozen_string_literal: true

module FlashMessage
  # Simple flash message component
  class Component < ViewComponent::Base
    attr_reader :type, :message

    def initialize(type:, message:)
      @type = type
      @message = message
      super
    end

    private

    # rubocop:disable Layout/LineLength
    # rubocop:disable Metrics/MethodLength
    def color_classes
      case type.to_sym
      when :success
        {
          panel: 'text-green-800 rounded-lg bg-green-50 dark:bg-gray-800 dark:text-green-400',
          button: 'bg-green-50 text-green-500 focus:ring-green-400 hover:bg-green-200 dark:bg-gray-800 dark:text-green-400 dark:hover:bg-gray-700'
        }
      when :error
        {
          panel: 'text-red-800 bg-red-50 dark:bg-gray-800 dark:text-red-400',
          button: 'bg-red-50 text-red-500 focus:ring-red-400 hover:bg-red-200 dark:bg-gray-800 dark:text-red-400 dark:hover:bg-gray-700'
        }
      when :warning
        {
          panel: 'text-yellow-800 rounded-lg bg-yellow-50 dark:bg-gray-800 dark:text-yellow-300',
          button: 'bg-yellow-50 text-yellow-500 focus:ring-yellow-400 hover:bg-yellow-200 dark:bg-gray-800 dark:text-yellow-300 dark:hover:bg-gray-700'
        }
      when :notice
        {
          panel: 'text-blue-800 bg-blue-50 dark:bg-gray-800 dark:text-blue-400',
          button: 'bg-blue-50 text-blue-500 focus:ring-blue-400 hover:bg-blue-200 dark:bg-gray-800 dark:text-blue-400 dark:hover:bg-gray-700'
        }
      else
        {
          panel: 'bg-gray-50 dark:bg-gray-800',
          button: 'bg-gray-50 text-gray-500 focus:ring-gray-400 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700 dark:hover:text-white'
        }
      end
    end
    # rubocop:enable Layout/LineLength
    # rubocop:enable Metrics/MethodLength
  end
end
