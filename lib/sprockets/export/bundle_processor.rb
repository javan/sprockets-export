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
      export.strip!

      body = [head, tail]
        .reject { |s| s == "" }
        .map(&:strip)
        .join("\n")
        .gsub(/\A;$/, "")
        .strip

      { namespace: namespace, export: export, body: body }
    end
end
