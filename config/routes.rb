Rails.application.routes.draw do
  resources :blog_posts
  root to: redirect('blog_posts')
end
