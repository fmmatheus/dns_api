class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    include Pagy::Backend
end
