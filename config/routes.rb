Rails.application.routes.draw do
  root 'api/v1/blogs#index'

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :users
      resources :blogs
    end
  end
end
