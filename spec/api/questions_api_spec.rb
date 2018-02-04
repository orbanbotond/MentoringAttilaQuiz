require 'spec_helper'

RSpec.describe Quiz::Questions, type: :api do
  let(:params) { {per_page: 2, page: 1} }

  context 'GET /api/v1/question' do

    it 'returns 200' do
      result = call_api(params)
      expect(result.status).to eq(200)
    end

    context 'without search' do
      context '1 question in database' do
        before do
          question = create(:question)
          QuestionIndex.reset!
        end
        context 'requesting first page' do
          it 'returns 1 existing question' do
            question = Question.first
            result = call_api(params.merge({page: 1}))

            expect(result.status).to eq(200)
            questions = JSON.parse(result.body)
            expect(questions.length).to eq(1)
            questionHash = questions.first
            expect(questionHash["name"]).to eq(question.name)
            expect(questionHash["deleted"]).to eq(question.deleted)
          end
        end
        context 'requesting 2nd page' do
          it 'returns 0 question' do
            # question = create(:question)
            # QuestionIndex.reset!
            result = call_api(params.merge({page: 2}))

            expect(result.status).to eq(200)
            questions = JSON.parse(result.body)
            expect(questions.length).to eq(0)
          end
        end
      end
      context '5 questions in database' do
        before do
          question = create_list(:question,5)
          QuestionIndex.reset!
        end
        it 'returns 2 existing questions (3th and 4th)' do
          result = call_api(params.merge({page: 2}))

          expect(result.status).to eq(200)
          questionsHash = JSON.parse(result.body)
          expect(questionsHash.length).to eq(2)
        end
      end
    end

    context 'with search' do
      before do
        category = create(:category)
        questions = []
        (1..5).each do |i|
          questions << create(:question, category_id: category.id, name: "myQuestion"+i.to_s)
        end
        QuestionIndex.reset!
      end

      context '1 question matches search term' do
        it 'returns matched question' do
          result = call_api(params.merge(search_term: "n2"))

          expect(result.status).to eq(200)
          questionsHash = JSON.parse(result.body)
          expect(questionsHash.length).to eq(1)
          questionHash = questionsHash.first
          expect(questionHash["name"]).to eq("myQuestion2")
        end
      end

      context 'more questions match search term' do
        it 'returns 2 matched questions (first page)' do
          result = call_api(params.merge(search_term: "est"))

          expect(result.status).to eq(200)
          questionsHash = JSON.parse(result.body)
          expect(questionsHash.length).to eq(2)
        end
      end

      context 'no question matches category_id' do
        it 'returns 0 questions' do
          result = call_api(params.merge(category_id: -1))

          expect(result.status).to eq(200)
          questionsHash = JSON.parse(result.body)
          expect(questionsHash.length).to eq(0)
        end
      end
    end

  end

  context 'GET /api/v1/question/:id' do
    context 'question exists' do
      it 'returns question by id' do
        question = create(:question)
        QuestionIndex.reset!
        result = call_api({id: question.id})

        expect(result.status).to eq(200)
        questionHash = JSON.parse(result.body)
        expect(questionHash["name"]).to eq(question.name)
        expect(questionHash["deleted"]).to eq(question.deleted)
        expect(questionHash["category_id"]).to eq(question.category_id)
      end 
    end
    context 'question doesnt exist' do
      it 'raises ActiveRecord::RecordNotFound' do
        QuestionIndex.reset!
        expect{ call_api({id: 1}) }.
            to raise_error(ActiveRecord::RecordNotFound, "Couldn't find Question with 'id'=1")
      end
    end 
  end

  let(:answer_params) { [
            {name: "Answer1", correct: false},
            {name: "Answer2", correct: true},
            {name: "Answer3", correct: false}
          ] }
  let(:question_params) { {name: "QuestionName", answers: answer_params} }

  context 'POST /api/v1/question' do
    context 'valid parameters' do
      it 'creates a question' do
        category = create(:category)
        result = call_api(question_params.merge(category_id: category.id))

        expect(result.status).to eq(201)
        question = Question.first
        expect(question.name).to eq("QuestionName")
        expect(question.deleted).to be false
        expect(question.category_id).to eq(category.id)
        expect(question.answers.length).to eq(3)
        expect(question.answers.where(correct: true).length).to eq(1)
        expect(question.answers.where(correct: true).first.name).to eq('Answer2')
      end
    end
    context 'invalid hash parameters' do
      it 'returns 400 (missing parameter)' do
        result = call_api(question_params)

        expect(result.status).to eq(400)
        expect(JSON.parse(result.body)["error"]).to eq("category_id is missing")
      end
    end
    context 'validation fails' do
      it 'return 400 (validation fails)' do
        category = create(:category)
        result = call_api(question_params.merge(category_id: category.id, name: "Short"))

        expect(result.status).to eq(400)
        expect(JSON.parse(result.body)["error"]).to eq("name" => ["is too short (minimum is 10 characters)"])
      end
    end
  end

  context 'PUT /api/v1/question/:id' do
    context 'valid parameters' do
      it 'updates question name' do
        question = create(:question)
        result = call_api({id: question.id, name: "QuestionName"})

        updatedQuestion = Question.last
        expect(result.status).to eq(200)
        expect(updatedQuestion.name).to eq("QuestionName")
        expect(updatedQuestion.deleted).to be false
        expect(updatedQuestion.category_id).to eq(question.category_id)
        expect(updatedQuestion.answers).to eq(question.answers)
      end

      it 'updates question category' do
        question = create(:question)
        category = create(:category)
        result = call_api({id: question.id, category_id: category.id})

        updatedQuestion = Question.last
        expect(result.status).to eq(200)
        expect(updatedQuestion.name).to eq(question.name)
        expect(updatedQuestion.deleted).to be false
        expect(updatedQuestion.category_id).to eq(category.id)
        expect(updatedQuestion.answers).to eq(question.answers)
      end

      it 'deletes an answer' do
        question = create(:question)
        result = call_api({id: question.id, answers_attributes: [{id: question.answers.first.id, _destroy: true}]})

        updatedQuestion = Question.last
        expect(result.status).to eq(200)
        expect(updatedQuestion.name).to eq(question.name)
        expect(updatedQuestion.deleted).to be false
        expect(updatedQuestion.category_id).to eq(question.category_id)
        expect(updatedQuestion.answers.length).to eq(2) 
        expect(updatedQuestion.answers.map {|a| a.id}).to eql(question.answers.last(2).map {|a| a.id})
      end

      it 'change all answers to correct' do
        question = create(:question)
        answers = question.answers
        result = call_api({id: question.id, 
          answers_attributes: 
            question.answers.map { |answer| {id: answer.id, correct: true, _destroy: false}}
            })
        
        updatedQuestion = Question.last
        expect(result.status).to eq(200)
        expect(updatedQuestion.name).to eq(question.name)
        expect(updatedQuestion.deleted).to be false
        expect(updatedQuestion.category_id).to eq(question.category_id)
        expect(updatedQuestion.answers.length).to eq(3)
        expect(updatedQuestion.answers.map {|a| a.correct} ).to eql(Array.new(3, true))
      end

      it 'add new answer' do
        question = create(:question)
        result = call_api({id: question.id,
          answers_attributes:
            [ {name: "NewAnswer", correct: false, _destroy: false}]
            })
        
        updatedQuestion = Question.last
        expect(result.status).to eq(200)
        expect(updatedQuestion.name).to eq(question.name)
        expect(updatedQuestion.deleted).to be false
        expect(updatedQuestion.category_id).to eq(question.category_id)
        expect(updatedQuestion.answers.length).to eq(4)
        expect(updatedQuestion.answers.last.name).to eq("NewAnswer")
        expect(updatedQuestion.answers.last.correct).to be false
      end
    end

    context 'validation fails' do
      it 'return 400 (validation fails)' do
        question = create(:question)
        result = call_api({ id: question.id, name: "Short"})

        expect(result.status).to eq(400)
        expect(JSON.parse(result.body)["error"]).to eq("name" => ["is too short (minimum is 10 characters)"])
      end
    end
  end

  context 'DELETE /api/v1/question/:id' do
    context 'valid id' do
      it 'marks question as deleted' do
        question = create(:question)
        result = call_api({ id: question.id })

        expect(result.status).to eq(200)
        expect(Question.where(deleted: false).length).to eq(0)
      end
    end

    context 'question doesnt exist' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect{ call_api({id: 1}) }.
            to raise_error(ActiveRecord::RecordNotFound, "Couldn't find Question with 'id'=1")
      end
    end 
  end

end