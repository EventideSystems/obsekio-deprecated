require 'rails_helper'

RSpec.describe "checklist_instances/show", type: :view do
  before(:each) do
    assign(:checklist_instance, ChecklistInstance.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
