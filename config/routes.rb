Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
  	namespace 'v1' do
  		
  		resources :skus
  		post '/', to: '/api/v1/skus#notification'
  		get '/', to: '/api/v1/skus#return_filtered_skus'
  	end
  end
end
