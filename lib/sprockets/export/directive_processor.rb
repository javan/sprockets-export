class Sprockets::DirectiveProcessor
  def process_export_directive(namespace, *flags)
    if @content_type == "application/javascript"
      Sprockets::Export::Store.set(@environment, @filename, [namespace, flags].flatten.join(" "))
      process_depend_on_directive "sprockets/export/version.rb"
    end
  end
end
