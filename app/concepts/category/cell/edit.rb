module Category::Cell
  class Edit < Trailblazer::Cell


    include BootstrapForm::Helper
    include ActionView::Helpers::FormHelper

    include Formular::RailsHelper
  end
end