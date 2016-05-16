require "pathname"

require "sprockets/export/version"
require "sprockets/export/namespace"
require "sprockets/export/directive_processor"
require "sprockets/export/metadata_injector"
require "sprockets/export/bundle_processor"

Sprockets.append_path Pathname.new(__dir__).join("..")
Sprockets.register_postprocessor    "application/javascript", Sprockets::Export::MetadataInjector
Sprockets.register_bundle_processor "application/javascript", Sprockets::Export::BundleProcessor
