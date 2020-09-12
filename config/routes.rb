Rails.application.routes.draw do
  resources :blogs
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :users
    end
  end
end
