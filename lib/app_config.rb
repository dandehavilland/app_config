require 'yaml'
require 'active_support/core_ext/hash'
module AppConfig
  VERSION = "1.0.4"
  
  def self.clear!
    @configurations = {}
  end
  
  def self.[](key=nil)
    @configurations if key.nil?
    ((@configurations||={})[key.to_s] ||= Accessor.new(key.to_s)).raw
  end
  
  class Accessor
    def initialize(filename)
      @config = load(filename)
    end

    def raw
      @config
    end

    private
    def load(filename)
      conf_yml = HashWithIndifferentAccess.new(
        YAML::load(
          ERB.new(
            IO.read(File.join(Rails.root, 'config', "#{filename}.yml"))).result))[Rails.env.to_s]
    end
  end
end