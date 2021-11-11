# frozen_string_literal: true

class Manage::Legacy::ApplicationController < ApplicationController
  before_action :authenticate_user!
  verify_authorized
end
