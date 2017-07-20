require 'rails_helper'

def reindex
  QuestionIndex.delete! rescue nil
  QuestionIndex.create
  QuestionIndex.import
end

RSpec.describe QuestionIndex do
  context 'search amongst comprehensive entities' do
    let!(:question) { create :question, name: "First question" }

    before do
      reindex
    end

    context 'compound terms' do
      context 'negative cases' do
        specify 'no documents' do
          scope = SearchElastic.new("esr").call
          expect(scope.size).to eq(0)
        end
      end
      context 'positive cases' do
        specify 'find 1 question' do
          scope = SearchElastic.new("est").call
          expect(scope.size).to eq(1)
        end
        specify 'find 1 question with upper case term' do
          scope = SearchElastic.new("EsT").call
          expect(scope.size).to eq(1)
        end
        specify 'find 1 question with asciifolding' do
          scope = SearchElastic.new("Ésŧ").call
          expect(scope.size).to eq(1)
        end
        specify 'find 1 question (via answers found)' do
          scope = SearchElastic.new("orr").call
          expect(scope.size).to eq(1)
        end

      end
    end
  end
end
