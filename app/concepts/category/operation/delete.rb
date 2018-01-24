class Category::Delete < Trailblazer::Operation
  step Model(Category, :find_by)
  step :delete!

  def delete!(options, model:, **)
    model.destroy
  end
end