# frozen_string_literal: true

#
# Create Metrics values
class MetricController < ApplicationController
  def create
    MetricService.add(metrics_params)
    render json: { }
  end

  def sum
    metrics = MetricService.sum(params[:key])
    render json: { value: metrics }
  end

  private

  def metrics_params
    params.permit(:key, :value)
  end
end
