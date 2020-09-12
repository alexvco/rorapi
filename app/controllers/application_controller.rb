class ApplicationController < ActionController::API
  include ApiResponse
  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def routing_error
    api_error title: 'Not found',
              detail: 'Requested route was not found',
              status: :not_found
  end

  def render_404
    api_error title: 'Not found',
              detail: 'Requested resource was not found',
              status: :not_found
  end

  def render_500(exception)
    raise exception if Rails.env.development? || Rails.env.test?

    api_error title: exception.class.to_s,
              detail: exception.message,
              status: :internal_server_error
  end
end
