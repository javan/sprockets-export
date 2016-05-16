class Sprockets::DirectiveProcessor
  def process_export_directive(namespace)
    if @content_type == "application/javascript"
      Sprockets::Export::Namespace.save(@environment, @filename, namespace)
      process_depend_on_directive "sprockets/export/version.rb"
    end
  end
end
