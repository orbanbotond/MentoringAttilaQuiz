class Admin::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /questions
  # GET /questions.json
  def index
    # QuestionIndex.reset!
    
    @categories = Category.all
    category_id = if params[:category].present?
      [params[:category].to_i]
    else
      @categories.map(&:id)
    end

    per_page = 10

    @question_indexes = SearchElastic
      .new(params[:search_term], category_id)
      .call
      .paginate(:per_page => per_page, :page => params[:page])

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
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.deleted = false
    respond_to do |format|
      if @question.save
        format.html { redirect_to admin_questions_url, notice: 'Question was successfully created.' }
        format.json { render :index, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question.paper_trail.touch_with_version
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to admin_questions_url, notice: 'Question was successfully updated.' }
        format.json { render :index, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.update_attribute :deleted, true
    respond_to do |format|
      format.html { redirect_to admin_questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
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
