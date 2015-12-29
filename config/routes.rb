Rails.application.routes.draw do
  scope path: '/admin' do
    resources :sportgoods
    resources :sportgoods_categories
    resources :sportgoods_subcategories
    resources :skates
    resources :snowrolls
    resources :icesleds
    resources :tubings
    resources :sleds
    resources :kickscooters
    devise_for :users
    resources :kidsbikes
    resources :bikes
    resources :manufacturers
    resources :electriccars
    resources :skis
    scope path: '/manage' do
      resources :users
    end
    get '/', to: 'manufacturers#index', as: 'admin'
    get '/manufacturers/:id/display/:flag', to: 'manufacturers#change_display', as: 'change_display'
    get '/manufacturers/category/:category', to: 'manufacturers#index'
    delete '/images/:product_id/:image_id', to: 'images#destroy', as: 'image'
    get '/:product_class/:product_id/:image_id/preview', to: 'preview#set', as: 'preview'
  end

  mount API::Root => '/'
end
