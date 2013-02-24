Contractor::Application.routes.draw do
  root                            :to => 'pages#home',      :via => :get
  match '/calendar',              :to => 'pages#calendar',  :via => :get
  match '/contact',               :to => 'pages#contact',   :via => :get
  match '/faq',                   :to => 'pages#faq',       :via => :get
  match '/impressum',             :to => 'pages#legal',     :via => :get
  match '/languages_and_prices',  :to => 'pages#prices',    :via => :get
  match '/translations',          :to => 'pages#offer',     :via => :get
  
  resources :customers, :only => [:index, :show, :edit, :new, :update, :create]
  resources :products,  :only => [:index, :show, :edit, :new, :update, :create]
  
  resources :projects,  :only => [:index, :show, :edit, :new, :update, :create] do
    resources :line_items, :only => [:edit, :new, :update, :create, :destroy], :controller => 'projects/line_items' do
    end
  end

end
