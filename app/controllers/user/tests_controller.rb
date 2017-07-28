class User::TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /tests
  def index
    @tests = Test.all
  end

  def show
    @number_of_correct_answers = @test.number_of_correct_answers
    @number_of_answers = @test.questions_tests_size

    @questions_tests = @test.questions_tests_all.paginate(:page => params[:page], :per_page => 1)
  end

  def answer_questions
    @test = Test.find(params[:id])
    increase_step_number

    unless @test.is_current_step?('evaluate', session[:step_number]) and @test.is_previous_step?('show_correct', session[:step_number])
      @previous_question = unless @test.is_previous_step?('question', session[:step_number])
        @test.questions[session[:number_of_answers] - 0]
      else 
        @test.questions[session[:number_of_answers] - 1]
      end

      @questions_test = @test.find_questions_test_by_question(@previous_question)
      save_marked_answers(@questions_test, params)

      session[:number_of_correct_answers] += 1 if @questions_test.answered_correct?

      @question = @test.questions[session[:number_of_answers]]

      session[:number_of_answers] += 1 if @test.is_current_step?('question', session[:step_number])
    end

    @number_of_answers = session[:number_of_answers]
    @number_of_correct_answers = session[:number_of_correct_answers]
  end

  # GET /tests/new
  def new
    @test = Test.new
    @categories = Category.all
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  def create
    @test = Test.new(test_params)
    @test.questions = Question.where(category_id: params["categories"]).order("RANDOM()").limit(test_params["number_of_questions"].to_i)

    if @test.questions_size < test_params["number_of_questions"].to_i
      @test.number_of_questions = @test.questions_size
      notice = "There wasn't enough questions in the database! Number of questions: #{@test.number_of_questions}"
    else 
      notice = 'Test was successfully created.'
    end

    if @test.save
      session[:step_number] = -1
      session[:number_of_answers] = 0
      session[:number_of_correct_answers] = 0 
      @test.create_steps(params[:show_results])
      redirect_to "/tests/#{@test.id}/answer_questions", notice: notice
    else
      render :new
    end
  end

  # PATCH/PUT /tests/1
  def update
    if @test.update(test_params)
      redirect_to @test, notice: 'Test was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tests/1
  def destroy
    @test.destroy
    redirect_to tests_url, notice: 'Test was successfully destroyed.'
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

    def save_marked_answers(questions_test, params)
      questions_test.question_answers_each do |answer|
        questions_test.answer_ids << answer.id if params["#{answer.id}"] == "1"
      end
      questions_test.save
    end

    def increase_step_number
      unless session[:step_number] != -1 && @test.current_step(session[:step_number]).eql?('evaluate')
        session[:step_number] = session[:step_number] + 1
      end
    end
end
