class Answer::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Answer, :find_by)
    step Contract::Build( constant: Answer::Contract::Create)
  end

  step Nested( Present )
  step Contract::Validate( key: :answer )
  step Contract::Persist()
end