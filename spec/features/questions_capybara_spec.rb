require 'rails_helper'

require 'spec_helper'

def reindex
      QuestionIndex.delete! rescue nil
      QuestionIndex.create
      QuestionIndex.import
    end

describe 'questions page' do
  it 'open new question page' do
    reindex
    visit '/questions'
    click_link('New Question')
    expect(page).to have_text("New Question")
  end

  it 'minimum 1 correct answer /negative' do
    visit '/questions/new'
    fill_in 'question[name]', :with => "New Qestion Name"
    fill_in 'question[answers_attributes][0][name]', :with => "answer1"
    fill_in 'question[answers_attributes][1][name]', :with => "answer2"
    fill_in 'question[answers_attributes][2][name]', :with => "answer3"
    click_button('Save question')
    expect(page).to have_text("No correct answer")
  end

  it 'minimum 1 correct answer /positive' do
    visit '/questions/new'
    fill_in 'question[name]', :with => "New Question Name"
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

  it 'delete correct answers and save' do
    visit '/categories/new'
    fill_in 'Name', :with => "New Category"
    fill_in 'Description', :with => "Description of new Category"
    click_button 'Save category'
    visit '/questions/new'
    fill_in 'question[name]', :with => "New Question Name"
    find('#question_category_id').find(:xpath, 'option[2]').select_option
    fill_in 'question[answers_attributes][0][name]', :with => "answer1"
    fill_in 'question[answers_attributes][1][name]', :with => "answer2"
    fill_in 'question[answers_attributes][2][name]', :with => "answer3"
    check 'question[answers_attributes][0][correct]'
    click_button('Save question')

    click_link('New Question Name')
    expect(page).to have_content("Delete answer")
    first('table').click_link 'Delete answer'
    click_button('Save question')
    expect(page).to have_content("No correct answer")
    
    expect {find_field('Name', with: 'answer1')}.to raise_error(Capybara::ElementNotFound)
  end

  context 'new context' do
    reindex
    let!(:question) { create :question, name: "First question" }

    before do
      reindex
    end

    specify 'should search after returning from unsubmited new question' do

      visit '/questions'

      expect(page).to have_content("First question")
      
      reindex
      fill_in 'search', :with => 'est'
      expect(page).to have_content("First question")

      fill_in 'search', :with => 'esr'
      expect(page).to have_content("No questions found")

      click_link('New Question')
      click_link('Back to questions')
      expect(page).to have_content("Listing questions")

      fill_in 'search', :with => 'est'
      expect(page).to have_content("First question")

      fill_in 'search', :with => 'esr'
      expect(page).to have_content("No questions found")      
    end
  end

end