class Category::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Category, :new)
    step Contract::Build( constant: Category::Contract::Create)
  end

  step Nested( Present )
  step Contract::Validate( key: :category )
  step Contract::Persist()
end