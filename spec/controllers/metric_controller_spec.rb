# frozen_string_literal: true

require 'rails_helper'

describe MetricController, type: :request do
  describe 'POST' do
    context 'with valid parametres' do
      before(:each) do
        allow(Metric).to receive(:create).and_call_original
      end

      it 'then return success' do
        post '/metric/errors', params: { value: 55 }
        expect(response).to have_http_status(:success)
      end

      it 'then return empty body' do
        post '/metric/errors', params: { value: 55 }
        expect(response.body).to eq('{}')
      end

      it 'create a new metrics with given attributes' do
        expect(Metric).to receive(:create)
        post '/metric/errors', params: { value: 55 }
      end
    end

    context 'with invalid parameters' do
      before(:each) do
        allow(Metric).to receive(:create).and_call_original
      end

      it 'then return errors' do
        post '/metric/errors'
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET" do

    context 'metric/:key/sum' do
      before(:each) do
        allow(MetricSumService).to receive(:run).and_call_original
      end

      it 'then return success' do
        get '/metric/errors/sum'
        expect(response).to have_http_status(:success)
      end
    end

    context 'when Metric Service return invalid' do
      before(:each) do
        allow(MetricSumService).to receive(:run).and_call_original
        allow_any_instance_of(MetricSumService).to receive(:valid?).and_return(false)
      end

      it 'then return error' do
        get '/metric/key/sum'
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
