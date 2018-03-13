class EventsController < ApplicationController

  def index
    @events = Event.all
    @events = Event.search(params[:search])
  end
end
