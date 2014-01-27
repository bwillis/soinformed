module SoInformed
  class MessageBuilderText

    attr_reader :text
    attr_accessor :optional, :fallback

    def initialize(text)
      @text = text
    end

    def fallback=(shorter_text)
      throw ArgumentError.new 'Fallback text should be shorter than given text' if shorter_text.length > @text.length
      @fallback = shorter_text
    end

    def min_text
      if @optional
        ''
      elsif @fallback
        @fallback
      else
        @text
      end
    end

    def min_size
      if @optional
        0
      elsif @fallback
        @fallback.size
      else
        @text.size
      end
    end

    def max_size
      @text.size
    end

  end
end