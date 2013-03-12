# encoding: UTF-8
module MongoidExt
  module Taggable
    extend ActiveSupport::Concern
    
    included do
      field :tags, :type => Array, :default => []
      index :tags => 1
      scope :tagged_by, ->(*tags){ where :tags.in => tags }
    end  

    module ClassMethods  
      #Other class method here.      
    end  
  end
end

