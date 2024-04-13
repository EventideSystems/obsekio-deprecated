require 'rails_helper'

RSpec.describe "checklist_instances/index", type: :view do
  before(:each) do
    assign(:checklist_instances, [
      ChecklistInstance.create!(),
      ChecklistInstance.create!()
    ])
  end

  it "renders a list of checklist_instances" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
