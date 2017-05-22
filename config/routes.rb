Rails.application.routes.draw do
  root 'application#hello'
  
  get '/hello'   => 'application#hello'
  get '/goodbye' => 'application#goodbye'
end
