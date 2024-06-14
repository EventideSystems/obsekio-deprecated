# frozen_string_literal: true

module MarkdownStateFilters
  # Private class to convert markdown to HTML as radio buttons
  class Radio < Base
    def _handle_element(element, state, index)
      element.remove_attribute('checked')
      name = radio_group_name(state)

      update_primary_radio_input(element, state, name, index)
      after = [secondary_radio_input(state, name, index)] << additional_radio_inputs(state, name, index)

      element.after(after.compact.join(''), as: :html)
    end

    def additional_radio_input(additional_state, state, name, index, item_index)
      options = radio_input_options(
        id: "#{name}_#{(index + 3).ordinalize}",
        name:,
        text: additional_state.text,
        color: radio_classes(additional_state.color),
        item_index:
      ).tap do |opts|
        opts['checked'] = 'checked' if state&.dig('state') == additional_state.text
      end

      content_tag(:input, '', options)
    end

    def additional_radio_inputs(state, name, item_index)
      return [] if checklist_instance.data_entry_radio_additional_states.blank?

      checklist_instance.data_entry_radio_additional_states.map.with_index do |additional_state, index|
        additional_radio_input(additional_state, state, name, index, item_index)
      end
    end

    RADIO_CLASSES = 'mr-2 h-4 w-4 border-gray-300'

    def radio_classes(color_key)
      color_classes = COLORS[color_key.to_sym].join(' ')

      "#{RADIO_CLASSES} #{color_classes}"
    end

    # SMELL: Need to be careful here. If two checklist items have the same text they will end up with the
    # same group name.
    def radio_group_name(state)
      return SecureRandom.hex(10) if state['text'].blank?

      state['text'].parameterize.underscore
    end

    def radio_input_options(id:, name:, text:, color:, item_index:)
      {
        type: 'radio',
        name:,
        id:,
        value: text,
        title: text,
        class: color,
        data: { item_index: }
      }
    end

    def secondary_radio_input(state, name, item_index)
      options = radio_input_options(
        id: "#{name}_secondary",
        name:,
        text: checklist_instance.data_entry_radio_secondary_text,
        color: radio_classes(checklist_instance.data_entry_radio_secondary_color),
        item_index:
      ).tap do |opts|
        opts['checked'] = 'checked' if state&.dig('state') == checklist_instance.data_entry_radio_secondary_text
      end

      content_tag(:input, '', options)
    end

    def update_primary_radio_input(element, state, name, item_index) # rubocop:disable Metrics/AbcSize
      element['type'] = 'radio'
      element['class'] = radio_classes(checklist_instance.data_entry_radio_primary_color)
      element['name'] = name
      element['id'] = "#{element['name']}_primary"
      element['value'] = element['title'] = checklist_instance.data_entry_radio_primary_text || ''
      element['checked'] = 'checked' if state&.dig('state') == checklist_instance.data_entry_radio_primary_text
      element['data-item-index'] = item_index.to_s
    end
  end
end
