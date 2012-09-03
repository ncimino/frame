module ApplicationHelper
  def title(page_title)
    content_for :title do
      page_title
    end
    page_title
  end

  def logo
    image_tag("econtriver_logo.gif", {:alt => "eContriver", :class => "round", :style => "width: 192px; height: 50px"})
  end
end
