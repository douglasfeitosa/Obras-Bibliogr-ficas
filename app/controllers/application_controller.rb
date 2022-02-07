class ApplicationController < ActionController::API
  def index
    render json: { message: 'Welcome' }
  end
end
