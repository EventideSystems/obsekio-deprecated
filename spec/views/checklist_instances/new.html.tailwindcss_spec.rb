require 'rails_helper'

RSpec.describe "checklist_instances/new", type: :view do
  before(:each) do
    assign(:checklist_instance, ChecklistInstance.new())
  end

  it "renders new checklist_instance form" do
    render

    assert_select "form[action=?][method=?]", checklist_instances_path, "post" do
    end
  end
end
