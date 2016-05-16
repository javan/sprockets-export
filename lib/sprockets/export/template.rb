require "erb"

class Sprockets::Export::Template
  CONTENT = Pathname.new(__dir__).join("template.js.erb").read

  def initialize(data = {})
    data.each do |key, value|
      instance_variable_set("@#{key}".to_sym, value)
    end
  end

  def render
    ERB.new(CONTENT).result(binding)
  end

  private
    def indent(string, amount)
      lines = string.lines
      result = lines.shift
      lines.each do |line|
        result << line.gsub(/^(?!$)/, " " * amount)
      end
      result
    end
end
