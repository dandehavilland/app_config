require 'yaml'
require 'hashie'
# require 'active_support/core_ext/hash'
module AppConfig
  VERSION = "1.1"
  
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
      conf_yml = ConfHash[
        YAML::load(
          ERB.new(
            IO.read(File.join(Rails.root, 'config', "#{filename}.yml"))).result)]
      
      if defined?(Rails)
        conf_yml[Rails.env]
      else
        conf_yml
      end
    end
  end
  
  class ConfHash < Hash
    alias_method :orig_accessor, :[]
    
    def [] key=nil
      orig_accessor key.to_s
    rescue
      super
    end
  end
end