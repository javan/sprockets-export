require "erb"

class Sprockets::Export::Template
  def self.content
    @content ||= Sprockets::Export.lib_path.join("sprockets/export/template.js.erb").read
  end

  def initialize(data = {})
    data.each do |key, value|
      instance_variable_set("@#{key}".to_sym, value)
    end
  end

  def render
    ERB.new(self.class.content, nil, "-").result(binding).strip + "\n"
  end

  private
    def indent(string, amount)
      lines = string.lines.to_a
      result = lines.shift
      lines.each do |line|
        result << line.gsub(/^(?!$)/, " " * amount)
      end
      result
    end
end
