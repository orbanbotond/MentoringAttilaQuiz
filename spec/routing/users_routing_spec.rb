require "rails_helper"

RSpec.describe User::UsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/users").to route_to("user/users#index")
    end

    it "routes to #new" do
      expect(:get => "/users/new").to route_to("user/users#new")
    end

    it "routes to #show" do
      expect(:get => "/users/1").to route_to("user/users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/users/1/edit").to route_to("user/users#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/users").to route_to("user/users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/users/1").to route_to("user/users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/users/1").to route_to("user/users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/users/1").to route_to("user/users#destroy", :id => "1")
    end

  end
end
