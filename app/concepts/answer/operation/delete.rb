class Answer::Delete < Trailblazer::Operation
  step Model(Answer, :find_by)
  step :delete!

  def delete!(options, model:, **)
    model.destroy
  end
end