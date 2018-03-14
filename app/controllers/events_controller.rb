class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
  end

  def search
    @events = Event.search(params[:search])
  end
end
