require 'yaml'

module AppConfig
  VERSION = "1.1.3"
  
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
    
    class << self
      def [] data
        h = super
        h.convert_children
      end
    end
    
    def initialize data
      super
      convert_children
    end
    
    def convert_children
      keys.each do |key|
        value = self[key]
        if value.is_a?(Hash)
          self[key] = ConfHash[value]
        end
      end
      self
    end
    
    def has_key? key
      super(key.to_s) || super(key.to_sym)
    end
    
    def [] key=nil
      orig_accessor(key.to_s) || orig_accessor(key.to_sym)
    rescue
      super
    end
  end
end