class ApplicationController < ActionController::Base
  include Pagy::Backend  # para usar `pagy` no controller
end