Rails.application.routes.draw do
  namespace :admin do
    get 'products/new'
    get 'products/index'
    get 'products/show'
    get 'products/edit'
  end
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
    resources :genres, only: [:index, :create, :edit, :update]
  end


  # 顧客用
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: 'customer/registrations',
    sessions:      'customer/sessions'
  }

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
      post 'confirm'
      get 'thanks'
    end
  end
  resource :customers, only: [:edit, :update] do
    collection do
      get 'mypage' => 'customers#show'
      get 'unsubscribe'
      patch 'withdraw'
    end
  end
  resources :deliveries, except: [:new, :show]

end
