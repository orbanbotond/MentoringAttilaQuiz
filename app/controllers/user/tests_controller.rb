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
    @questions_tests = @test.questions_tests

    @number_of_answers = @questions_tests.size
    @number_of_correct_answers = 0

    @questions_tests.each do |qt|
      correct = 1
      qt.question.answers.each_with_index do |answer, index|
        answer_boolean = false
        if qt.marked_answer.present? && qt.marked_answer[index] == "1"
          answer_boolean = true
        end
        if answer.correct ^ answer_boolean
          correct = 0
        end
      end
      @number_of_correct_answers += correct
    end

    @questions_tests = @questions_tests.paginate(:page => params[:page], :per_page => 1)
  end

  def answer_questions
    @test = Test.find(params[:id])

    unless session[:nr] != -1 && @test.current_step(session[:nr]).eql?('evaluate')
      session[:nr] = session[:nr] + 1
    end

    @button_text = "Submit answer"
    if @test.current_step(session[:nr]).eql?('show_correct')
      set_number_of_correct_answers(@test, params, 1)
      @button_text = "Next question"

    elsif @test.current_step(session[:nr]).eql?('question')
      session[:number_of_answers] += 1
      if @test.current_step(session[:nr] - 1).eql?('question')
        set_number_of_correct_answers(@test, params, 2)
      end

    elsif @test.current_step(session[:nr] - 1).eql?('question')
      set_number_of_correct_answers(@test, params, 1)
    end

    @question = @test.questions[session[:number_of_answers]-1]

    if @test.current_step(session[:nr] + 1).eql?('evaluate')
      @button_text = "Finish test"
    end

    @number_of_answers = session[:number_of_answers]
    @number_of_correct_answers = session[:number_of_correct_answers]
  end

  # GET /tests/new
  def new
    @test = Test.new
    p params
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)
    @test.questions = Question.where(category_id: params["categories"]).order("RANDOM()").limit(test_params["number_of_questions"].to_i)

    if @test.questions.size < test_params["number_of_questions"].to_i
      @test.number_of_questions = @test.questions.size
      notice = "There wasn't enough questions in the database! Number of questions: #{@test.number_of_questions}"
    else 
      notice = 'Test was successfully created.'
    end

    respond_to do |format|
      if @test.save
        session[:nr] = -1
        session[:number_of_answers] = 0
        session[:number_of_correct_answers] = 0 
        @test.create_steps(params[:show_results])
        format.html { redirect_to "/tests/#{@test.id}/answer_questions", notice: notice }
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

    def check_answers(answers, params, questions_test)
      correct = true
      questions_test[0].marked_answer = ""
      answers.each do |answer|
        answer_boolean = false
        questions_test[0].marked_answer << params["#{answer.id}"].to_s
        if params["#{answer.id}"] == "1"
          answer_boolean = true
        end
        if answer.correct ^ answer_boolean 
          correct = false
        end
      end
      questions_test[0].save
      if correct
        1
      else 
        0
      end
    end

    def set_number_of_correct_answers(test, params, prev_nr)
      previous_question = test.questions[session[:number_of_answers]-prev_nr]
      questions_test = test.questions_tests.where(:question_id => previous_question.id )
      session[:number_of_correct_answers] += check_answers(previous_question.answers, params, questions_test)
    end
end
