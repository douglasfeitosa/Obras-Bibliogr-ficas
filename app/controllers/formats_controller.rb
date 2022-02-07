class FormatsController < ApplicationController
  def create
    render json: {
      formatted_names: FormatService.call(format_params[:names])
    }
  end

  private

  def format_params
    params.permit(names: [])
  end
end
