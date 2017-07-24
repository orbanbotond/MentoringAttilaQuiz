require "rails_helper"

RSpec.describe Admin::AnswersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/answers").not_to be_routable
    end

    it "routes to #new" do
      expect(:get => "/admin/answers/new").not_to be_routable
    end

    it "routes to #show" do
      expect(:get => "/admin/answers/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(:get => "/admin/answers/1/edit").not_to be_routable
    end

    it "routes to #create" do
      expect(:post => "/admin/answers").to route_to("admin/answers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/answers/1").to route_to("admin/answers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/answers/1").to route_to("admin/answers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/answers/1").to route_to("admin/answers#destroy", :id => "1")
    end

  end
end
