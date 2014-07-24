module PlaylistHelper

  def state_label state
    case state
    when 'inactive'
      content_tag(:span, 'Inactive', class: 'label label-danger')
    when "in_progress"
      content_tag(:span, 'In progress', class: 'label label-warning')
    when 'active'
      content_tag(:span, 'Active', class: 'label label-success')
    end
  end
end
