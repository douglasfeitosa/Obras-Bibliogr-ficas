class FormatsController < ApplicationController
  before_action :verify_params

  def create
    render json: {
      formatted_names: FormatService.call(format_params[:names] || [])
    }
  end

  private

  def verify_params
    render json: { message: "invalid params" } unless format_params[:names].is_a?(Array)
  end

  def format_params
    params.permit(names: [])
  end
end
