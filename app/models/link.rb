class Link < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :item, :as => :details
end
