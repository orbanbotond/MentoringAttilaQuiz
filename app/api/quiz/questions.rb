module Quiz
  class Questions < Grape::API

    resource :question do

      desc "List all questions"
      params do
        optional :search_term, type: String
        requires :page, type: Integer
        requires :per_page, type: Integer
        optional :category_id, type: Integer
      end
      get do
        category_id = if params[:category_id].present?
          [params[:category_id].to_i]
        else
          Category.all.map(&:id)
        end

        result = SearchElastic
          .new(params[:search_term], category_id)
          .call
          .paginate(:per_page => params[:per_page], :page => params[:page])

        questions = []
        result.each do |res|
          questions << res._data["_source"]
        end
        return questions
      end

      desc "Return question by id"
      params do
        requires :id, type: Integer
      end
      route_param :id do
        get do
          Question.find(params[:id])
        end
      end

      desc "Create question"
      params do
        requires :name, type: String
        requires :category_id, type: Integer
        requires :answers, type: Array do
          requires :name, type: String
          requires :correct, type: Boolean
        end
      end
      post do
        question = Question.create!({
          name: params[:name],
          deleted: false,
          category_id: params[:category_id],
          answers_attributes: params[:answers]
        })
      end

      desc "Update question"
      params do
        requires :id, type: String
        optional :name, type: String
        optional :category_id, type: Integer
        optional :answers_attributes, type: Array do
          optional :id, type: String
          optional :name, type: String
          optional :correct, type: Boolean
          requires :_destroy, type: Boolean
        end
      end
      put ':id' do
        question = Question.find(params[:id])
        question.paper_trail.touch_with_version
        question.update!(params)
      end

      desc "Delete question"
      params do
        requires :id, type: String
      end
      delete ':id' do
        Question.find(params[:id]).update_attribute :deleted, true
      end
    end

  end
end