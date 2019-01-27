Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
# -----------------------------------------------------------------

      namespace :merchants do
        get '/random', to: 'random#show'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        # get '/most_revenue', to: 'most_revenue#index'
        # get '/most_items', to: 'most_items#index'
        # get '/revenue', to: 'revenue#index'
      end

      scope module: 'merchants' do
        resources :merchants, only: [:index, :show] do
          get '/items', to: 'items#index'
          get '/invoices', to: 'invoices#index'
        end
      end
# ----------------------------------------------------------------

      namespace :items do
        get '/random', to: 'random#show'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        # get '/most_revenue', to: 'most_revenue#index'
        # get '/most_items', to: 'most_items#index'
        # get '/revenue', to: 'revenue#index'
      end

      scope module: 'items' do
        resources :items, only: [:index, :show] do
          get '/invoice_items', to: 'invoice_items#index'
          get '/merchant', to: 'merchant#show'
        end
      end
#-------------------------------------------------------------------
      scope module: 'customers' do
        resources :customers, only: [:index, :show] do
          get '/invoices', to: 'invoices#index'
          get '/transactions', to: 'transactions#index'
        end
      end

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

#----------------------------------------------------------------------
      scope module: 'transactions' do
        resources :transactions, only: [:index, :show] do
          get '/invoice', to: 'invoice#show'
        end
      end

#------------------------------------------------------------------------
      scope module: 'invoice_items' do
        resources :invoice_items, only: [:index, :show] do
          get '/invoice', to: 'invoice#show'
          get '/item', to: 'item#show'
        end
      end

    end
  end
end
