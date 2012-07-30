The86Sample::Application.routes.draw do

  root to: redirect("/sites")

  resources :sites,
    only: [:index, :show] do

    resources :conversations,
      only: [:create] do

      resources :posts,
        only: [:create]

    end

  end

  match "sign-in", to: "authentication#sign_in", as: :sign_in
  match "sign-out", to: "authentication#sign_out", as: :sign_out

end
