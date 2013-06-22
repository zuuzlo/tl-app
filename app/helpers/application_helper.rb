module ApplicationHelper

  def full_title(page_title)

    base_title = "Health and Safety Post it Board"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def display_datetime(dt)

    dt.strftime("%b %d, %Y at %I:%M%p")    #Month, day, year at 8:00 am
  end
end
