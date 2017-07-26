require 'spec_helper'

describe 'tests' do
  context 'generating new test' do
    context 'negative' do
      it 'submit uncompleted form' do
        visit '/tests/new'
        
        expect(page).to have_content("Number of questions")
        expect(page).to have_content("Select categories")

        find_button('Start quiz').click

        expect(page).to have_content("No chosen categories")
      end
    end

    context 'positive' do
      it 'submit correctly completed form' do
      visit '/tests/new'
        
        expect(page).to have_content("Number of questions")
        expect(page).to have_content("Select categories")

        


        find_button('Start quiz').click
      end
    end
  end
end