module ContactsHelper

  def notify_state_button(notify_state)
    c = case notify_state
      when :only_mention
        content_tag(:i, "", :class => "icon-comment") +
            content_tag(:span, "#mention")
      when :"6_hours"
        content_tag(:i, "", :class => "icon-time") +
            content_tag(:span, "6 hours")
      when :always
        content_tag(:i, "", :class => "icon-heart") +
            content_tag(:span, "always")
      when :never
        content_tag(:i, "", :class => "icon-ban-circle") +
            content_tag(:span, "never")
    end

    raw content_tag :a, c, :"data-value" => notify_state, :class => "btn btn-default btn-lg btn-large-icon btn-notify-state"
  end
end
