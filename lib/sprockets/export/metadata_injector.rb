module Sprockets::Export::MetadataInjector
  extend self

  def call(input)
    data, environment, filename = *input.values_at(:data, :environment, :filename)

    if namespace = Sprockets::Export::Namespace.find(environment, filename)
      open = "/* !START EXPORT #{namespace} */"
      close = "/* !END EXPORT */"
      data = [open, data.chomp, close].join("\n") + "\n"
    end

    { data: data }
  end
end
