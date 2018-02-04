require 'spec_helper'

RSpec.describe Quiz::Categories, type: :api do

  context 'GET /api/v1/category' do
    it 'returns 200' do
      expect(call_api.status).to eq(200)
    end

    it 'returns 1 existing category' do
      category = create(:category)
      expect(call_api.status).to eq(200)
      categories = JSON.parse(call_api.body)
      expect(categories.length).to eq(1)
      expect(categories.first["name"]).to eq(category.name)
      expect(categories.first["description"]).to eq(category.description)
    end

    it 'returns 10 existing categories' do
      create_list(:category, 10)
      expect(call_api.status).to eq(200)
      categories = JSON.parse(call_api.body)
      expect(categories.length).to eq(10)
    end
  end

  context 'POST /api/v1/category' do
    context 'positive' do
      it 'creates a category' do
        result = call_api({name: "myNewCategory", description: "myDescription"})
        expect(result.status).to eq(201)
        expect(Category.first.name).to eq("myNewCategory")
        expect(Category.first.description).to eq("myDescription")
      end
    end

    context 'negative' do
      conetxt 'missing parameters' do
        it 'returns 400' do
          result = call_api
          expect(result.status).to eq(400)
          expect(JSON.parse(result.body)["error"]).to eq("name is missing, description is missing")
        end
      end
    end
  end

  context "PUT /api/v1/category/:id" do
    context 'positive' do
      it 'updates a category' do
        category = create(:category)
        result = call_api({id: category.id, name: "modifiedName", description: "modified"})

        expect(result.status).to eq(200)
        expect(Category.first.name).to eq("modifiedName")
        expect(Category.first.description).to eq("modified")
      end
    end
    context 'negative' do
      context 'missing parameters' do
        it 'returns 400' do
          category = create(:category)
          result = call_api({id: category.id})

          expect(result.status).to eq(400)
          expect(JSON.parse(result.body)["error"]).to eq("name is missing, description is missing")
        end
      end

      context 'category not found' do
        it 'raises ActiveRecord::RecordNotFound' do
          expect{ call_api({id: 1, name: "modifiedName", description: "modified"}) }.
            to raise_error(ActiveRecord::RecordNotFound, "Couldn't find Category with 'id'=1")
        end
      end
    end
  end

  context "DELETE /api/v1/category/:id" do
    context 'positive' do
      it 'deletes a category' do
        category = create(:category)
        result = call_api({id: category.id})

        expect(result.status).to eq(200)
        expect(Category.all).to be_empty
      end
    end
    context 'negative' do
      context 'category not found' do
        it 'raises ActiveRecord::RecordNotFound' do
          expect{ call_api({id: 1}) }.
            to raise_error(ActiveRecord::RecordNotFound, "Couldn't find Category with 'id'=1")
        end
      end
    end
  end

end