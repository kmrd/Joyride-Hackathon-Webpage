module ApplicationHelper

  # returns full title on a per-page basis
  def full_title(page_title = '')
    base_title = Rails.configuration.site_title || ''
    tag_line = Rails.configuration.site_description || ''

    if page_title.empty?
      "#{base_title} :: #{tag_line}"
    else
      "#{page_title} :: #{base_title}"
    end
  end

  def body_class(classes = '')
    unless classes.empty?
      "class=\"#{classes}\""
    end
  end
end