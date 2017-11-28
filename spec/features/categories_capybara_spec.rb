require 'spec_helper'

describe 'categories page' do
  before(:each) do
    Warden.test_reset!
    Warden.test_mode!

    member = FactoryGirl.create(:admin)

    login_as(member, :scope =>  :member)

  end

  after(:each) do
    Warden.test_reset!
  end

  context 'test' do
    it 'testttt' do
      visit '/tests'
      expect(page).to have_text("Listing")
    end

    it 'open new category page' do
      visit '/admin/categories/new'
      expect(page).to have_text("Back to categories")
    end

    it 'create new category' do
      visit '/admin/categories/new'
      fill_in 'Name', :with => "New Category"
      fill_in 'Description', :with => "Description of new Category"
      click_button 'Save category'
      expect(Category.where(name: "New Category", description: "Description of new Category")).to exist
    end

    it 'try to create category without name' do
      visit '/admin/categories/new'
      fill_in 'Name', :with => ""
      fill_in 'Description', :with => "Description of new Category"
      click_button 'Save category'
      expect(Category.where(name: "", description: "Description of new Category")).not_to exist
    end

    it 'edit existing category' do
      visit '/admin/categories/new'
      fill_in 'Name', :with => "New Category Name"
      fill_in 'Description', :with => "Description of new Category"
      click_button 'Save category'
      visit '/admin/categories'
      click_link('New Category Name')
      fill_in 'Name', :with => "Modified Category Name"
      click_button 'Save category'
      expect(Category.where(name: "Modified Category Name", description: "Description of new Category")).to exist
    end
  end
end




