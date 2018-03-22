class RepliesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @event = Event.find(params[:event_id])
    @reply = @event.replies.new(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_back(fallback_location: root_path)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment, :number)
  end
end
