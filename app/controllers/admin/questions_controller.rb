class Admin::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  def index
    if params[:search].present?
      @question_indexes = SearchElastic.new(params[:search]).call.paginate(:per_page => 2, :page => params[:page])
    else
      @question_indexes = QuestionIndex.all.paginate(:per_page => 2, :page => params[:page])
    end
    respond_to :html, :js
  end

  # GET /questions/new
  def new
    @question = Question.new
    3.times do
      @question.answers.new
    end
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admin_questions_url, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.save
      redirect_to admin_questions_url, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to admin_questions_url, notice: 'Question was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:name, :category_id, {answers_attributes: [:name, :correct, :id, :_destroy]})
    end
end
