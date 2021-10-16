Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')

  # Elba: https://guides.rubyonrails.org/routing.html
  # In general, you should use the get, post, put, patch,
  # and delete methods to constrain a route to a
  # particular verb. You can use the match method with
  # the :via option to match multiple verbs at once.
  # Basically, this helps create find_with_director_path without directors being a resource.
  match "/movies/find_with_director/:id", to: "movies#find_with_director", as: 'find_with_director', via: [:get]
end
