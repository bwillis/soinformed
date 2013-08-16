class Contacts < Array
  def location_display_grouped_phone_numbers
    self.inject({}) do |hash, contact|
      hash[contact.location_display] ||= []
      hash[contact.location_display] << contact.phone_number
      hash
    end
  end

  def location_displays
    self.collect { |contact| contact.location_display }.uniq
  end

  def mark_all_notified!
    self.each { |contact| contact.mark_notified! }
  end
end