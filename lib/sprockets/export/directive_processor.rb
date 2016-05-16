class Sprockets::DirectiveProcessor
  def process_export_self_directive
    if @content_type == "application/javascript"
      process_stub_directive("sprockets/export_stub")
      process_require_self_directive
    end
  end
end
