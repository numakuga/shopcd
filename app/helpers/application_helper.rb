module ApplicationHelper
  def page_title
    title = "ANAGO-SHOP"
    title = @page_title + "[#{title}]" if @page_title
    title
  end
end
