class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]

  def index
  end
end
