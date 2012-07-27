The86Sample::Application.routes.draw do

  root to: redirect("/sites")

  resources :sites,
    only: [:index]

end
