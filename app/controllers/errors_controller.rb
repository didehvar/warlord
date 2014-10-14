class ErrorsController < ApplicationController
  def not_found
    render json: { error: 'not-found' }, status: :not_found
end
