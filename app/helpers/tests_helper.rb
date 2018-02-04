module TestsHelper

  # helpers for answer_questions.html.slim
  
  def render_partials(form, test, step_number)
    render "#{test.current_step(step_number)}_step", :f => form
  end

  def add_submit_button(form, test, step_number)
    if test.current_step(step_number) != 'evaluate'
      button_text = @test.is_current_step?('show_correct', session[:step_number]) ? "Next question" : "Submit answer"
      button_text = "Finish test" if @test.is_current_step?('evaluate', session[:step_number] + 1)
      form.submit button_text
    end
  end

  def confirm_message(test, step_number)
    data = {}
    unless test.current_step(step_number).eql? "evaluate"
      data = {confirm: 'Are you sure to leave the test?'}
    end
    return data
  end

  # helpers for show.html.slim

  def add_checkbox(form, questions_test, answer)
    checked = questions_test.answer_marked?(answer)
    form.check_box answer.id, label: answer.name, checked: checked, disabled: "disabled", inline: true    
  end

  def add_label(form, questions_test, answer)
    label = answer.correct ? :correct : :incorrect
    color = answer.correct ? :green : :red
    form.label label, style: "color: #{color}" if label == :correct or questions_test.answer_marked?(answer)
  end

end
