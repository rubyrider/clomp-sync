module Clomp::Sync
  class Param
    include ActiveModel::Model
    
    def initialize(**attributes)
      attributes.each do |key, value|
        singleton_class.instance_eval {attr_accessor key.to_sym} unless self.respond_to?(key.to_sym)
      end
      
      self.assign_attributes(attributes)
    end
    
    def add(attribute)
      singleton_class.instance_eval {attr_accessor attribute.to_sym} unless self.respond_to?(attribute.to_sym)
    end
    
    def validates(*attributes, **validator)
      singleton_class.instance_eval { validates *attributes, validator}
    end
    
    class << self
      def setup(&block)
        @params ||= self.new

        @params.instance_eval &block
        
        @params
      end
    end
  end
end