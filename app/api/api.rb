class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  format :json

  # rescue_from ActiveRecord::RecordInvalid do |error|
  #   message = error.record.errors.messages.map { |attr, msg| {attr => msg.first} }
  #   p message
  #   error!(message.join(", "), 404)
        
  # end  

  rescue_from ActiveRecord::RecordInvalid do |error|
    x = {}
    error.record.errors.each do |attr, msg|
      if x.key?(attr)
        x[attr] << msg
      else
        x[attr] = [msg]
      end
    end

    rack_response({
              error: x
            }.to_json, 400)
  end
  
  mount Quiz::Categories
  mount Quiz::Questions
end