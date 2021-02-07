module ExceptionHandler
    extend ActiveSupport::Concern
  
    included do
        rescue_from ActionController::ParameterMissing do |e|
            json_response({ message: e.message }, :unprocessable_entity)
        end

        rescue_from Pagy::OverflowError do |e|
            json_response({ 
                total_records: 0,
                records: [],
                related_hostnames: []
            })
        end
    end
end