module ApplicationHelper

  # A button group relies on a array of hashes to describe the
  # buttons. Each button needs the following properties:
  # {
  #  :text => "displayed text"
  #  :icon => "name of the icon to use"
  #  :value => "data value to post to the server"
  # }
  def select_icon_button_group(name, buttons, default_value=nil)
    content_tag(:div, :class => "btn-group btn-group-justified", :"data-toggle-name" => name, :"data-toggle" => "buttons-radio") do
      buttons.collect do |button|
        content_tag :a, :"data-value" => button[:value], :class => "btn btn-default btn-lg btn-large-icon btn-notify-state" do
          content_tag(:i, "", :class => "icon-#{button[:icon]}") + content_tag(:span, button[:text])
        end
      end.join("").html_safe
    end + hidden_field_tag(name, default_value, :class => "hidden")
  end

  def sprite_link(name, link, opts)
    opts[:class] ||= ""
    opts[:class] << " #{name}"
    link_to("", link, opts).html_safe
  end

  def errors_helper(model)
    if model.errors.any?
      content_tag(:div, :id => "error_explanation") do
        content_tag(:h2, pluralize(@contact.errors.count, "error") + " prohibited this contact from being saved:")
        content_tag(:ul) do
          @contact.errors.full_messages.each { |msg| content_tag(:li, msg) }
        end
      end
    end
  end

end