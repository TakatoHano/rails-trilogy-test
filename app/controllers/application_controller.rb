class ApplicationController < ActionController::Base
    skip_forgery_protection
    
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    
    def render_404
        render json: { message: "not found."}, status: :not_found
    end

    def render_error_json(keys = [], messages = [], status)
        errors = {}
        errors[:keys] = keys if keys.present?
        errors[:messages] = keys if keys.present?

        render json: { errors: errors}, status: status
    end
end
