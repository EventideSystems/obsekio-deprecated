require "rails_helper"

RSpec.describe ChecklistInstancesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/checklist_instances").to route_to("checklist_instances#index")
    end

    it "routes to #new" do
      expect(get: "/checklist_instances/new").to route_to("checklist_instances#new")
    end

    it "routes to #show" do
      expect(get: "/checklist_instances/1").to route_to("checklist_instances#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/checklist_instances/1/edit").to route_to("checklist_instances#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/checklist_instances").to route_to("checklist_instances#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/checklist_instances/1").to route_to("checklist_instances#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/checklist_instances/1").to route_to("checklist_instances#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/checklist_instances/1").to route_to("checklist_instances#destroy", id: "1")
    end
  end
end
