# frozen_string_literal: true

class API::ApplicationController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :authenticate_user!
  verify_authorized
end
