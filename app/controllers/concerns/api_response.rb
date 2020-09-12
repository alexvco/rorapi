module ApiResponse
  def api_response(payload: {}, status: :ok)
    render json: payload.try(:serializable_hash) || payload,
           status: status
  end

  def api_success(message: 'Request was successful', status: :ok)
    render json: {
      status: status,
      message: message
    }, status: status
  end

  def api_error(title: 'Bad Request', detail: 'Please check your parameters', status: :bad_request)
    render json: {
      error: {
        status: status,
        title: title,
        detail: detail
      }
    }, status: status
  end
end
