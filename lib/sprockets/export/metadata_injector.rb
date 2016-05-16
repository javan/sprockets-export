require "execjs"

module Sprockets::Export::MetadataInjector
  extend self

  def call(input)
    data = input[:data]

    if input[:metadata][:stubbed].any? { |r| r.index("sprockets/export_stub")}
      context = extract_context(data)
      if context.keys.any?
        namespace = context.keys.join(" ")
        open = "/* !START EXPORT #{namespace} */"
        close = "/* !END EXPORT */"
        data = [open, data.chomp, close].join("\n") + "\n"
      end
    end

    { data: data }
  end

  private
    def extract_context(source)
      js = %Q(
        _getContext = function() {
          var context = {};
          (function() { #{source} }).call(context);
          return context;
        }
      )

      ExecJS.compile(js).call("_getContext")
    end
end
