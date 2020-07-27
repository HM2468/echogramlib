Rails.application.routes.draw do

    resources :users

    resources :echogram_temps, only: [:new,:create,:index,:show,:destroy]
    resources :composition_temps,only:[:new,:create,:destroy]

    get    '/new',          to: 'sessions#new'    
    get    '/home',         to: 'homepage#home'
    get    '/search',       to: 'homepage#search'
    get    '/querygram',    to: 'query#querygram'
    get    '/details',      to: 'query#details'
    get    '/loadpage',     to: 'upload#loadpage'
    get    '/newgramtemp',  to: 'upload#newgramtem'
    get    '/myupload',     to: 'upload#myupload'
    get    '/signup',       to: 'users#new'
    post   '/signup',       to: 'users#create'
    get    '/login',        to: 'sessions#new'
    post   '/login',        to: 'sessions#create'
    delete '/logout',       to: 'sessions#destroy'

    root 'homepage#home'

end
