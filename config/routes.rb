Rails.application.routes.draw do
  post 'dns_records', to: 'api_v1#create'
  get 'dns_records', to: 'api_v1#show'
end
