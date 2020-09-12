Rails.application.routes.draw do
  root 'api/v1/blogs#index'

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      match '/users',          to: 'users#index',   via: :get,           as:   :users
      match '/users',          to: 'users#create',  via: :post
      match '/users/new',      to: 'users#new',     via: :get,           as:   :new_user
      match '/users/:id/edit', to: 'users#edit',    via: :get,           as:   :edit_user
      match '/users/:id',      to: 'users#show',    via: :get,           as:   :user
      match '/users/:id',      to: 'users#update',  via: [:patch, :put]
      match '/users/:id',      to: 'users#destroy', via: :delete

      resources :categories
      resources :blogs
      resources :images
    end
  end

  match '*a', to: 'application#routing_error', via: %i[delete get patch post], defaults: { format: :json }
end
