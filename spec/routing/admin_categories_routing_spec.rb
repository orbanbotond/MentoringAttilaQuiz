    require 'rails_helper'
 
RSpec.describe Admin::CategoriesController do
    it "routes index" do
     	expect(get("/admin/categories")).
     		to route_to("admin/categories#index")
    end

    it "routes new" do
    	expect(get("/admin/categories/new")).
    		to route_to("admin/categories#new")
    end

    it "routes edit" do
    	expect(get("/admin/categories/5/edit")).
    		to route_to(
    			:controller => "admin/categories",
    			:action => "edit",
    			:id => "5"
    			)
    end

    it "routes delete destroy" do
    	expect(delete("/admin/categories/5")).
    		to route_to(
    			:controller => "admin/categories",
    			:action => "destroy",
    			:id => "5"
    			)
    end

    it "routes post create" do
      expect(post("/admin/categories")).to route_to(
        :controller => "admin/categories",
        :action => "create"
      )
    end
 
    it "routes put update" do
      expect(put("/admin/categories/1")).to route_to(
        :controller => "admin/categories",
        :action => "update",
        :id => "1"
      )
    end

    it "does not route to show" do
    	expect(get("/admin/categories/5")).
    		not_to be_routable
    	end
end