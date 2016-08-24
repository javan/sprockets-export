module Sprockets::Export::MetadataInjector
  extend self

  def call(input)
    data, environment, filename = *input.values_at(:data, :environment, :filename)

    if metadata = Sprockets::Export::Store.get(environment, filename)
      open = "/* !START EXPORT #{metadata} */"
      close = "/* !END EXPORT */"
      data = [open, data.chomp, close].join("\n") + "\n"
    end

    { data: data }
  end
end
