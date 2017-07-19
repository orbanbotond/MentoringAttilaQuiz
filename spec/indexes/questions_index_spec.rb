require 'rails_helper'

def reindex
  QuestionIndex.delete! rescue nil
  QuestionIndex.create
  QuestionIndex.import
end

RSpec.describe QuestionIndex do

=begin
  context 'search amongst comprehensive entities' do
    let!(:question) { create :question }
    let!(:answer) { create :answer }

    before do
      reindex
    end

  context 'compound terms' do
      context 'negative cases' do
        specify 'no documents' do
          scope = SearchGlobally.new.call answer.text[0..1], user
          expect(scope[:total_count]).to eq(1)
        end
=end

end
