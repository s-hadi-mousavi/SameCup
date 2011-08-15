Samecup::Application.routes.draw do
  resources :user_stories

  resources :sprints

  devise_for :users,:controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :projects do
    resources :sprints do
      resources :stickers do
        member do
          put :sort
          get :setstate
        end
      end
    end
    resources :members do
      collection do
        post :invite
      end
      member do
        get :changerole
        delete :remove
      end
    end
    resources :user_stories do
      collection do
        post :add_sticker
        put :update_sticker
      end
      member do
        get :show_dialog
      end
    end

    member do
      get :refresh
      get :dashboard
      get 'report' => "report#index", :as => 'report'
    end
  end

  match '/profile/remove_twitter'  => "profile#remove_twitter", :as  => 'profile_remove_twitter'
  match '/profile/remove_facebook' => "profile#remove_facebook", :as => 'profile_remove_facebook'
  match '/profile/remove_google'   => "profile#remove_google", :as   => 'profile_remove_google'

  post '/feedback' => 'feedback#post', :as =>'feedback'

#  get '/users/invitation/:invitation_token' => 'invitations#edit', :as => 'accept_invitation'
#  put '/users/invitation/:invitation_token' => 'invitations#update', :as => 'update_invitation'

  match '/termsofuse'    => 'welcome#static', :as => :termsofuse
  match '/privacypolicy' => 'welcome#static', :as => :privacypolicy
  match '/prices'        => 'welcome#static', :as => :prices
  match '/tour'          => 'welcome#static', :as => :tour


  root :to => "welcome#index"
end
