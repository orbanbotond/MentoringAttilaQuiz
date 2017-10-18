class Admin::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /questions
  # GET /questions.json
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
  # POST /questions.json
  def create
    @question = Question.new(question_params)
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
    @question.destroy
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
