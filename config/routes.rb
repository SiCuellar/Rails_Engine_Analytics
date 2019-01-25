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

# ----------------------------------------------------------------
      scope module: 'items' do
        resources :items, only: [:index, :show] do
          get '/invoice_items', to: 'invoice_items#index'
          get '/merchant', to: 'merchant#show'
        end
      end

#-------------------------------------------------------------------
      resources :customers, only: [:index, :show]
      
#--------------------------------------------------------------------
      scope module: 'invoices' do
        resources :invoices, only: [:index, :show] do
          get '/transactions', to: 'transactions#index'
          get '/invoice_items', to: 'invoice_items#index'
          get '/items', to: 'items#index'
          get '/customer', to: 'customer#show'
          get '/merchant', to: 'merchant#show'
        end
      end

      resources :transactions, only: [:index, :show]

      resources :invoice_items, only: [:index, :show]
    end
  end
end
