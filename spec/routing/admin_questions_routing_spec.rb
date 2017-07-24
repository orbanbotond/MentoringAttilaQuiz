require "rails_helper"

RSpec.describe Admin::QuestionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/questions").to route_to("admin/questions#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/questions/new").to route_to("admin/questions#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/questions/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(:get => "/admin/questions/1/edit").to route_to("admin/questions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/questions").to route_to("admin/questions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/questions/1").to route_to("admin/questions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/questions/1").to route_to("admin/questions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/questions/1").to route_to("admin/questions#destroy", :id => "1")
    end

  end
end
