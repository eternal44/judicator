Rails.application.routes.draw do
  resources :report_groupings do
    resources :reports, shallow: true
  end

  resources :reports do
    resources :properties, shallow: true
  end
end

