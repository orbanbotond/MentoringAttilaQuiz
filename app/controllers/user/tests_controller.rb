class User::TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    session[:nr] = -1
    session[:number_of_correct_answers] = 0
    @tests = Test.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    @test = Test.find(params[:id])

    @button_text = "Submit answer"
    if @test.current_step(session[:nr]).eql?('question')

      @previous_question = @test.questions[session[:nr] / 2]
      session[:number_of_correct_answers] += check_answers(@previous_question.answers, params)
      
      @button_text = "Next question"
    end

    if session[:nr] < 2 * @test.questions.size
      session[:nr] = session[:nr] + 1
    end
    @question = @test.questions[session[:nr] / 2]

    if @test.current_step(session[:nr] + 1).eql?('evaluate')
      @button_text = "Finish test"
    end
  end

  # GET /tests/new
  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)
    @test.questions = Question.where(category_id: params["categories"]).order("RANDOM()").limit(test_params["number_of_questions"].to_i)

    respond_to do |format|
      if @test.save
        session[:nr] = -1
        session[:number_of_correct_answers] = 0 
        format.html { redirect_to @test, notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to @test, notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, notice: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:number_of_questions)
    end

    def check_answers(answers, params)
      correct = true
      answers.each do |answer|
        answer_boolean = false
        if params["#{answer.id}"] == "1"
          answer_boolean = true
        end
        if answer.correct ^ answer_boolean 
          correct = false
        end
      end
      if correct
        1
      else 
        0
      end
    end
end
