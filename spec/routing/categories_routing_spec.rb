require 'rails_helper'
 
RSpec.describe "routes for categories" do
    it "routes index" do
     	expect(get("/categories")).
     		to route_to("categories#index")
    end

    it "routes new" do
    	expect(get("/categories/new")).
    		to route_to("categories#new")
    end

    it "routes edit" do
    	expect(get("categories/5/edit")).
    		to route_to(
    			:controller => "categories",
    			:action => "edit",
    			:id => "5"
    			)
    end

    it "routes delete destroy" do
    	expect(delete("categories/5")).
    		to route_to(
    			:controller => "categories",
    			:action => "destroy",
    			:id => "5"
    			)
    end

    it "routes post create" do
      expect(post("categories")).to route_to(
        :controller => "categories",
        :action => "create"
      )
    end
 
    it "routes put update" do
      expect(put("categories/1")).to route_to(
        :controller => "categories",
        :action => "update",
        :id => "1"
      )
    end

    it "does not route to show" do
    	expect(get("categories/5")).
    		not_to be_routable
    	end
end