require 'spec_helper'

describe 'questions page' do
  it 'open new question page' do
    visit '/questions'
    click_link('New Question')
    expect(page).to have_text("Back to Questions")
  end

  it 'add new question' do
    visit '/questions/new'
    fill_in 'Name', :with => "New Question Name"
  end
end