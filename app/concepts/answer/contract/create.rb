require "reform"
require "reform/form/dry"

module Answer::Contract
  class Create < Reform::Form
    include Dry

    property :name
    property :correct

    validation do
      required(:name).filled(min_size?: 1, max_size?: 20)
    end
  end
end