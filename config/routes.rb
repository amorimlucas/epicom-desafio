Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
  	namespace 'v1' do
  		# Aqui todos os routes CRUD são criados para o modelo/mesa SKU
  		resources :skus
  		# Definição do endpoint para receber notificações de assoiação de SKU
  		post '/', to: '/api/v1/skus#notification'
  		# Definição do endpoint para retornar SKUs disponíveis e com preços entre 10 e 40 reais
  		get '/', to: '/api/v1/skus#return_filtered_skus'
  	end
  end
end
