class Item < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :details, :polymorphic => true
end
