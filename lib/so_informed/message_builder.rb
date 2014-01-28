require './lib/so_informed/message_builder_text'

module SoInformed
  class MessageBuilder

    attr_writer :add_spaces

    WORD_SUB = {
        'international' => 'int\'l',
        'International' => 'Int\'l'
    }

    def initialize
      @text       = []
      @add_spaces = false
    end

    def reset
      @text.clear
    end

    def add(input)
      return if input.nil?
      text = input.is_a?(MessageBuilderText) ? input : MessageBuilderText.new(input)
      if @add_spaces && !@text.empty?
        space          = MessageBuilderText.new ' '
        space.optional = text.optional
        @text << space
      end
      @text << text
    end

    def add_optional(text)
      t          = MessageBuilderText.new(text)
      t.optional = true
      add t
    end

    def add_with_fallback(text, shorter_text)
      t          = MessageBuilderText.new(text)
      t.fallback = shorter_text
      add t
    end

    def add_space
      add ' '
    end

    def add_ellipsis(text, min_length=text.length/2)
      add_with_fallback text, text.slice(0..min_length) + '...'
    end

    def message(desired_size=max_size)
      if max_size > desired_size
        message_types = %w(substitute_message fallback_text_message required_message shortest_message)
        message_types.each do |type|
          m = send(type)
          return m if m.size <= desired_size
        end
        # returning shortest message when we couldn't find one under the desired size
        shortest_message
      else
        @text.map(&:text).join
      end
    end

    def substitute_message
      @text.collect do |t|
        t.text.split(' ').collect do |word|
          WORD_SUB[word] || word
        end.join(' ')
      end.join
    end

    def fallback_text_message
      @text.collect { |t| t.fallback || t.text }.join
    end

    def required_message
      @text.collect { |t| t.text unless t.optional }.join
    end

    def shortest_message
      @text.map(&:min_text).join
    end

    def max_size
      @text.inject(0) { |ttl, t| ttl += t.max_size }
    end

    def min_size
      @text.inject(0) { |ttl, t| ttl += t.min_size }
    end
  end
end