module Category::Cell
  class New < Trailblazer::Cell
    include BootstrapForm::Helper
    include ActionView::Helpers::FormHelper

    include Formular::RailsHelper
  end
end