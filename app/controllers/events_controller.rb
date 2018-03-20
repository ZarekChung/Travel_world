class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search, :show]

  def index
  end
end
