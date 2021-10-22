Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, except: [:destroy] do
      collection do
        get 'search'
      end
    end
    resources :genres, only: [:index, :create, :edit, :update] do
      member do
        get '/' => 'genres#index'
      end
    end
  end


  # 顧客用
  devise_for :customers, skip: :all
  devise_scope :customer do
    get 'customers/sign_in' => 'customer/sessions#new', as: :new_customer_session
    post 'customers/sign_in' => 'customer/sessions#create', as: :customer_session
    delete 'customers/sign_out' => 'customer/sessions#destroy', as: :destroy_customer_session
    get 'customers/sign_up' => 'customer/registrations#new', as: :new_customer_registration
    post 'customers/sign_up' => 'customer/registrations#create', as: :customer_registration
  end

  scope module: :customer do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    resources :products, only: [:index, :show] do
      collection do
        get 'search'
      end
    end
    resources :cart_products, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get 'confirm'
        post 'confirm'
        get 'thanks'
      end
    end
    resource :customers, only: [:edit, :update] do
      collection do
        get 'mypage' => 'customers#show'
        get '/' => 'customers#show'
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    resources :deliveries, except: [:new, :show] do
      member do
        get '/' => 'deliveries#index'
      end
    end
  end
end