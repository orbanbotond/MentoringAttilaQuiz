module Quiz
  class Categories < Grape::API

    resource :category do
      desc "List all categories"
      get do
        Category.all
      end

      desc "Create a new category"
      ## This takes care of parameter validation
      params do
        requires :name, type: String
        requires :description, type: String
      end
      ## This takes care of creating employee
      post do
        Category.create!({
          name: params[:name],
          description: params[:description]
        })
      end

      desc "Update a category"
      params do
        requires :id, type: String
        requires :name, type:String
        requires :description, type:String
      end
      put ':id' do
        Category.find(params[:id]).update({
          name: params[:name],
          description: params[:description]
        })
      end

      desc "Delete a category"
      params do
        requires :id, type: String
      end
      delete ':id' do
        Category.find(params[:id]).destroy!
      end
    end

  end
end