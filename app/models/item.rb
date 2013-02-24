class Item < ActiveRecord::Base
  attr_accessible :name, :minutes, :img_url, :details_id, :details_type
  
  belongs_to :details, :polymorphic => true  
  
  def self.pizza
    return "yumm"
  end
  
end
