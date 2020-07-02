Rails.application.routes.draw do

    resources :users


    get    '/new',          to: 'sessions#new'    
    get    '/home',         to: 'homepage#home'
    get    '/search',       to: 'homepage#search'
    get    '/querygram',    to: 'query#querygram'
    get    '/details',      to: 'query#details'
    get    '/signup',       to: 'users#new'
    post   '/signup',       to: 'users#create'
    get    '/login',        to: 'sessions#new'
    post   '/login',        to: 'sessions#create'
    delete '/logout',       to: 'sessions#destroy'

    root 'homepage#home'

end
