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
    metrics = MetricSumService.run(key: params[:key])
    if metrics.valid?
      render json: { value: metrics.result, success: true }
    else
      render json: { errors: metrics.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def metrics_params
    params.permit(:key, :value)
  end
end
