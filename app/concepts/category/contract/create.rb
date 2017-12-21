require "reform"
require "reform/form/dry"

module Category::Contract
  class Create < Reform::Form
    include Dry

    property :name
    property :description

    validation do
      required(:name).filled
    end
  end
end