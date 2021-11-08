class ErrorsController < ApplicationController
  def forbidden
    respond_to do |format|
      format.html {
        render file: 'public/403.html', status: 403
      }
      format.json {
        render json: {}, status: :forbidden
      }
    end
  end

  def not_found
    respond_to do |format|
      format.html {
        render file: 'public/404.html', status: 404
      }
      format.json {
        render json: {}, status: :not_found
      }
    end
  end

  def unprocessable_entity
    respond_to do |format|
      format.html {
        render file: 'public/422.html', status: 422
      }
      format.json {
        render json: {}, status: :unprocessable_entity
      }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html {
        render file: 'public/500.html', status: 500
      }
      format.json {
        render json: {}, status: :internal_server_error
      }
    end
  end
end
