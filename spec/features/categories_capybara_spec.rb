require 'spec_helper'

#RSpec.reset

describe 'categories page' do
  it 'open new category page' do
    visit '/categories'
    click_link('New Category')
    expect(page).to have_text("Back to categories")
  end

  it 'create new category' do
  	visit '/categories/new'
  	fill_in 'Name', :with => "New Category"
  	fill_in 'Description', :with => "Description of new Category"
  	click_button 'Save category'
  	expect(Category.where(Name: "New Category", Description: "Description of new Category")).to exist
  end

  it 'edit existing category' do
  	visit '/categories/new'
  	fill_in 'Name', :with => "New Category Name"
  	fill_in 'Description', :with => "Description of new Category"
  	click_button 'Save category'
  	visit '/categories'
  	click_link('New Category Name')
  	fill_in 'Name', :with => "Modified Category Name"
  	click_button 'Save category'
  	expect(Category.where(Name: "Modified Category Name", Description: "Description of new Category")).to exist
  end
end
