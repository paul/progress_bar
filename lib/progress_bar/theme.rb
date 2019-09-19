# frozen_string_literal: true

class ProgressBar
  Theme = Struct.new(:bar_element,
                     :delimiter,
                     :open_delimiter,
                     :close_delimiter,
                     :line_prefix,
                     :line_suffix,
                     keyword_init: true) do
    def initialize(bar_element: "#", delimiter: ["[", "]"], line_prefix: "", line_suffix: "")
      super
    end

    def open_delimiter
      @open_delimiter ||= delimiter.is_a?(Array) ? delimiter.first : delimiter
    end

    def close_delimiter
      @close_delimiter ||= delimiter.is_a?(Array) ? delimiter.last : delimiter
    end

    def render_element(name, bar, **args)
      element = public_send(name)
      if element.respond_to?(:call)
        element.call(bar, **args)
      else
        element
      end
    end
  end
end
