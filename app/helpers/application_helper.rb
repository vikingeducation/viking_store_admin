module ApplicationHelper

  def self.created_date
    created_at.strftime("%m/%d/%y")
  end

  def format
    strftime("%m/%d/%y")
  end

end
