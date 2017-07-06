require "rails_helper"

RSpec.describe AnswersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/answers").not_to be_routable
    end

    it "routes to #new" do
      expect(:get => "/answers/new").not_to be_routable
    end

    it "routes to #show" do
      expect(:get => "/answers/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(:get => "/answers/1/edit").not_to be_routable
    end

    it "routes to #create" do
      expect(:post => "/answers").to route_to("answers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/answers/1").to route_to("answers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/answers/1").to route_to("answers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/answers/1").to route_to("answers#destroy", :id => "1")
    end

  end
end
