class ApplicationController < ActionController::Base
  protect_from_forgery

  # Use decent_exposure together with strong_parameters
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
