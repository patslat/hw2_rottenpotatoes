module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def sorter(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_by ? "hilite" : nil
    link_to title, {:sort => column}, {:class => css_class, :id => "#{column}_header"}
  end

end
