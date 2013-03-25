class BaseAuthenticationController < ApplicationController
  before_filter :authenticate_user!
end
