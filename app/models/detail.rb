class Detail < ApplicationRecord
  belongs_to :schedule
  belongs_to :spot
  belongs_to :category
  include RailsSortable::Model
  #model validation
  validates_presence_of :hr, :category_id
  set_sortable :sort  # Indicate a sort column

  def get_hour
    self.hr.strftime("%H").to_i + self.hr.strftime("%M").to_d/60
  end

  def time_formate
    self.strat_t.strftime("at %I:%M%p")
  end
end
