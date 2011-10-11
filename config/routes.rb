Rails.application.routes.draw do |map|

  mount_at = Cheese::Engine.config.mount_at

  match mount_at => 'cheese/widgets#index'
  
  match "#{mount_at}/syncs/new" => "cheese/syncs#new", :as => :sync_new
  match "#{mount_at}/syncs/callback" => "cheese/syncs#callback", :as => :sync_callback

  map.resources :widgets, :only => [ :index, :show ],
                          :controller => "cheese/widgets",
                          :path_prefix => mount_at,
                          :name_prefix => "cheese_"

end
