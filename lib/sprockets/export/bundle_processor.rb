require "sprockets/export/template"

module Sprockets::Export::BundleProcessor
  extend self

  PATTERN = /(.*)\/\* !START EXPORT (.*) \*\/(.*)\/\* !END EXPORT \*\/(.*)/m

  def call(input)
    Sprockets::Export::Namespace.reset
    data = input[:data]

    if data =~ PATTERN
      data = Sprockets::Export::Template.new(extract_template_data(data)).render
    end

    { data: data }
  end

  private
    def extract_template_data(js)
      _, head, namespace, export, tail = *js.match(PATTERN)

      { namespace: namespace,
        export: format(export),
        head: format(head),
        tail: format(tail) }
    end

    def format(part)
      part.strip.gsub(/\A;$/, "").strip
    end
end
