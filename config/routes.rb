Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'motivaders#index'
  
  get 'motivader/about' => 'motivaders#about'
  get 'motivader/view' => 'motivaders#view'

  get 'posts/books' => 'posts#books'
  get 'posts/videos' => 'posts#videos'
  get 'posts/comics' => 'posts#comics'
  get 'posts/words' => 'posts#words'

  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

end
