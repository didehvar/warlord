Rails.application.routes.draw do
  constraints format: 'json' do
    get '/404', to: 'errors#not_found'

    resources :users, except: [:new, :edit]
  end
end
