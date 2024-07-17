# frozen_string_literal: true

module FlashMessage
  # Simple flash message component
  class Component < ViewComponent::Base
    include Components::ToastHelper

    attr_reader :type, :message

    def initialize(type:, message:)
      @type = type
      @message = message
      super
    end

    def header = type
    def description = message

    def color_classes
      COLOR_CLASSES[type.to_sym]
    end

    COLOR_CLASSES = {
      success: 'text-green-800 bg-green-500 dark:bg-gray-800 dark:text-green-400',
      error: 'text-red-800 bg-red-500 dark:bg-gray-800 dark:text-red-400',
      warning: 'text-yellow-800 bg-yellow-500 dark:bg-gray-800 dark:text-yellow-300',
      notice: 'text-blue-800 bg-blue-500 dark:bg-gray-800 dark:text-blue-400',
      default: 'bg-gray-50 dark:bg-gray-800',
      alert: 'text-red-800 bg-red-500 dark:bg-gray-800 dark:text-red-400'
    }.freeze

    #
    # COLOR_CLASSES = {
    #   success: {
    #     panel: 'text-green-800 rounded-lg bg-green-50 dark:bg-gray-800 dark:text-green-400',
    #     button: 'bg-green-50 text-green-500 focus:ring-green-400 hover:bg-green-200 dark:bg-gray-800 dark:text-green-400 dark:hover:bg-gray-700'
    #   },
    #   error: {
    #     panel: 'text-red-800 bg-red-50 dark:bg-gray-800 dark:text-red-400',
    #     button: 'bg-red-50 text-red-500 focus:ring-red-400 hover:bg-red-200 dark:bg-gray-800 dark:text-red-400 dark:hover:bg-gray-700'
    #   },
    #   warning: {
    #     panel: 'text-yellow-800 rounded-lg bg-yellow-50 dark:bg-gray-800 dark:text-yellow-300',
    #     button: 'bg-yellow-50 text-yellow-500 focus:ring-yellow-400 hover:bg-yellow-200 dark:bg-gray-800 dark:text-yellow-300 dark:hover:bg-gray-700'
    #   },
    #   notice: {
    #     panel: 'text-blue-800 bg-blue-50 dark:bg-gray-800 dark:text-blue-400',
    #     button: 'bg-blue-50 text-blue-500 focus:ring-blue-400 hover:bg-blue-200 dark:bg-gray-800 dark:text-blue-400 dark:hover:bg-gray-700'
    #   },
    #   default: {
    #     panel: 'bg-gray-50 dark:bg-gray-800',
    #     button: 'bg-gray-50 text-gray-500 focus:ring-gray-400 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700 dark:hover:text-white'
    #   },
    #   alert: {
    #     panel: 'text-red-800 bg-red-50 dark:bg-gray-800 dark:text-red-400',
    #     button: 'bg-red-50 text-red-500 focus:ring-red-400 hover:bg-red-200 dark:bg-gray-800 dark:text-red-400 dark:hover:bg-gray-700'
    #   }
    # }.freeze
    #     private_constant :COLOR_CLASSES
  end
end
