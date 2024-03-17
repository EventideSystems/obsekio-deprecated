# frozen_string_literal: true

require 'rails_helper'

# Dummy ActiveRecord model for testing, based on the 'checklists' table as it has a status column.
class DummyModel < ApplicationRecord
  self.table_name = 'checklists'

  include StringEnum

  string_enum :status, %i[active inactive], default: :inactive
end

RSpec.describe StringEnum, type: :model do
  let(:model) { DummyModel.new }

  describe '#string_enum' do
    it 'defines an enum on the model' do
      expect(model.class).to respond_to(:statuses)
    end

    it 'maps the enum values to strings' do
      expect(model.class.statuses).to eq('active' => 'active', 'inactive' => 'inactive')
    end

    it 'sets the default value' do
      expect(model.status).to eq('inactive')
    end
  end
end
