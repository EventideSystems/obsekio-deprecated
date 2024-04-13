require 'rails_helper'

RSpec.describe "checklist_instances/edit", type: :view do
  let(:checklist_instance) {
    ChecklistInstance.create!()
  }

  before(:each) do
    assign(:checklist_instance, checklist_instance)
  end

  it "renders the edit checklist_instance form" do
    render

    assert_select "form[action=?][method=?]", checklist_instance_path(checklist_instance), "post" do
    end
  end
end
