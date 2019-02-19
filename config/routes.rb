Rails.application.routes.draw do
  get 'words/:id', to: 'words#show', as: 'words_show'
  get 'word_roots/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'word_roots#index'
end
