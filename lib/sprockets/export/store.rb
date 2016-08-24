module Sprockets::Export::Store
  extend self

  def set(environment, filename, data)
    mapping[environment] ||= {}
    mapping[environment][filename] = data
  end

  def get(environment, filename)
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
