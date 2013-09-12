module ApplicationHelper

  def sprite_link(name, link, opts)
    opts[:class] ||= ""
    opts[:class] << " #{name}"
    link_to("", link, opts).html_safe
  end

  def sitemap(text)
    "<h2>#{link_to('Examples', examples_path)} > #{text}</h2>".html_safe
  end
  
  def see_more(link)
    "<h4>#{link_to("See More at Foursquare Documentation", link)}</h4>".html_safe
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