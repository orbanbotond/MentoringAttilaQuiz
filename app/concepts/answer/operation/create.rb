class Answer::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Answer, :new)
    step Contract::Build( constant: Answer::Contract::Create)
  end

  step Nested( Present )
  step Contract::Validate( key: :answer )
  step Contract::Persist()
end