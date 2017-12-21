module Home::Cell
  class Layout < Trailblazer::Cell
    include ActionView::Helpers::CsrfHelper
    include Devise::Controllers::Helpers 
  end
end