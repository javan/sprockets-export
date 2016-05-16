class Sprockets::DirectiveProcessor
  def process_export_directive(namespace)
    if @content_type == "application/javascript"
      Sprockets::Export::Namespace.save(@environment, @filename, namespace)
    end
  end
end
