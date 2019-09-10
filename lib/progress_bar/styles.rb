class ProgressBar
  module Styles
    extend self

    ColorMap = {
      none: 0,
      bold: 1,
      italic: 3,
      underline: 4,
      inverted_black: 7,
      strikethrough: 9,
      black: 30,
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      magenta: 35,
      cyan: 36,
      inverted_red: 41,
      inverted_green: 42,
      inverted_yellow: 43,
      inverted_blue: 44,
      inverted_magenta: 45,
      inverted_cyan: 46,
      inverted_white: 47,
      light_grey: 90,
      light_red: 91,
      light_green: 92,
      light_yellow: 93,
      light_blue: 94,
      light_magenta: 95,
      light_cyan: 96,
      light_inverted_grey: 100,
      light_inverted_red: 101,
      light_inverted_green: 102,
      light_inverted_yellow: 103,
      light_inverted_blue: 104,
      light_inverted_magenta: 105,
      light_inverted_cyan: 106,
      light_inverted_white: 107,
    }

    def available_styles
      ColorMap.keys.each do |key|
        style_name = key.to_s
        style_code = ColorMap[key]

        styled_text = "\e[#{style_code}m[##############] [100/100] \e[0m"
        puts "#{style_name} (\e[1m#{style_code}\e[0m): #{styled_text}"
      end
    end

    # can be a valid key or value
    def process(style)
      return if style.nil? || style == ''
      return style if style == 0

      return code_from(style_from(style)) if style.is_a? Integer
      code_from(style) if ColorMap.keys.include?(key_from(style))
    end

    def style_from(code)
      ColorMap.key(code.to_i)
    end

    def code_from(style)
      ColorMap[key_from(style)]
    end

    def key_from(style)
      style.to_s.downcase.to_sym
    end
  end
end
