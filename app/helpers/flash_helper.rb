module FlashHelper

  FLASH_CLASS = {
      :notice => "alert-success",
      :error  => "alert-info",
      :alert  => "alert-danger"
  }

  FLASH_PREFIX = {
      :notice => "Hey!",
      :error  => "Whoops!",
      :alert  => "Uh Oh!"
  }

  def flash_banner
    flash.collect do |name, msg|
      unless msg.blank?
        content_tag(:div, :class => "alert #{FLASH_CLASS[name]} alert-dismissable", :"data-dismiss"=>"alert") do
          content_tag(:i, "", :class => "close icon-remove").html_safe + flash_prefix(name) + msg
        end
      end
    end.join("").html_safe
  end

  def flash_prefix(level)
    content_tag(:b, FLASH_PREFIX[level] + " ").html_safe
  end
end