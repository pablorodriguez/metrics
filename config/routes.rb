# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'metric/:key', to: 'metric#create'
  get 'metric/:key/sum', to: 'metric#sum'

end
