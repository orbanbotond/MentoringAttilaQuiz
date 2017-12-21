class Category::Index < Trailblazer::Operation
  step :model!

  def model!(options, *)
    options["model"] = ::Category.all.order(:name)
  end
end