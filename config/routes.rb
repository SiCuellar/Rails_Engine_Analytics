Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
# -----------------------------------------------------------------
      scope module: 'merchants' do
        resources :merchants, only: [:index, :show] do
          get '/items', to: 'items#index'
          get '/invoices', to: 'invoices#index'
        end
      end

      namespace :merchants do
        # get '/random', to: 'random#show'
        # get '/find', to: 'find#show'
        # get '/find_all', to: 'find#index'
        # get '/most_revenue', to: 'most_revenue#index'
        # get '/most_items', to: 'most_items#index'
        # get '/revenue', to: 'revenue#index'
      end
# ----------------------------------------------------------------

      resources :items, only: [:index, :show]



      resources :customers, only: [:index, :show]

      resources :invoices, only: [:index, :show]

      resources :transactions, only: [:index, :show]

      resources :invoice_items, only: [:index, :show]
    end
  end
end
