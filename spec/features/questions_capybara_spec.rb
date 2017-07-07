require 'spec_helper'

describe 'questions page' do
  it 'open new question page' do
    visit '/questions'
    click_link('New Question')
    expect(page).to have_text("New Question")
  end

  it 'minimum 1 correct answer /negative' do
    visit '/questions/new'
    fill_in 'question[name]', :with => "New Qestion"
    fill_in 'question[answers_attributes][0][name]', :with => "answer1"
    fill_in 'question[answers_attributes][1][name]', :with => "answer2"
    fill_in 'question[answers_attributes][2][name]', :with => "answer3"
    click_button('Save question')
    expect(page).to have_text("No correct answer")
  end

  it 'minimum 1 correct answer /positive' do
    visit '/questions/new'
    fill_in 'question[name]', :with => "New Qestion"
    fill_in 'question[answers_attributes][0][name]', :with => "answer1"
    fill_in 'question[answers_attributes][1][name]', :with => "answer2"
    check 'question[answers_attributes][1][correct]'
    fill_in 'question[answers_attributes][2][name]', :with => "answer3"
    click_button('Save question')
    expect(page).to_not have_text("No correct answer")
  end

  it 'more than 5 answers' do
    visit '/questions/new'
    click_link 'Add Answer'
    click_link 'Add Answer'
    click_link 'Add Answer'
    click_button('Save question')
    expect(page).to have_content("Too many answers (max 5)")
  end

end