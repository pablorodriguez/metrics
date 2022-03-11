# frozen_string_literal: true

#
# Create Metrics values
class MetricController < ApplicationController
  def create
    metric = Metric.create(metrics_params)
    if metric.persisted?
      render json: { }
    else
      render json: { errors: metric.errors }, status: :unprocessable_entity
    end
  end

  def sum
    metrics = MetricSumService.run(key: params[:name])
    render json: { value: metrics.result, success: true } if metrics.valid?
  end

  private

  def metrics_params
    params.permit(:key, :value)
  end
end
