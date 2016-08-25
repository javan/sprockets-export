require "sprockets/export/template"
require "ostruct"

module Sprockets::Export::BundleProcessor
  extend self

  PATTERN = /(.*)\/\* !START EXPORT (\S*)\s*(\S*) \*\/(.*)\/\* !END EXPORT \*\/(.*)/m

  def call(input)
    Sprockets::Export::Store.reset
    data = input[:data]

    if data =~ PATTERN
      data = Sprockets::Export::Template.new(extract_template_data(data)).render
    end

    { data: data }
  end

  private
    def extract_template_data(js)
      _, head, namespace, flags, export, tail = *js.match(PATTERN)

      { namespace: namespace,
        flags: create_flags(flags),
        export: format(export),
        head: format(head),
        tail: format(tail) }
    end

    def format(part)
      part.strip.gsub(/\A\s*;\n*|\n;\s*\z/, "").strip
    end

    def create_flags(string = "")
      flags = {}
      string.split.each { |flag| flags[flag] = true }
      OpenStruct.new(flags)
    end
end
