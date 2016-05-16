module Sprockets::Export::Namespace
  extend self

  def save(environment, filename, namespace)
    mapping[environment] ||= {}
    mapping[environment][filename] = namespace
  end

  def find(environment, filename)
    if mapping[environment]
      mapping[environment][filename]
    end
  end

  def reset
    @mapping = nil
  end

  private
    def mapping
      @mapping ||= {}
    end
end
