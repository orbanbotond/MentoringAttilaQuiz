module TestsHelper

  # helpers for answer_questions.html.slim
  
  def render_partials(form)
    render "#{@test.current_step(session[:step_number])}_step", :f => form
  end

  def add_submit_button(form)
    if @test.current_step(session[:step_number]) != 'evaluate'
     form.submit @button_text
    end
  end

  def confirm_message
    data = {}
    unless @test.current_step(session[:step_number]).eql? "evaluate"
      data = {confirm: 'Are you sure to leave the test?'}
    end
    return data
  end

end
