Rails.application.routes.draw do
  post 'dns_records', to: 'api_v1#create'
end
