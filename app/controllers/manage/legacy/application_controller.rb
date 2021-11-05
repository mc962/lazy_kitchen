class Manage::Legacy::ApplicationController < ApplicationController
  before_action :authenticate_user!
end