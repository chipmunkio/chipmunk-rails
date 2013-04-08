object @item

attribute :id
attribute :item_type
attribute :minutes
attribute :name
attribute :url
attribute :word_count

child :image do
  node :regular do |img| 
    img.asset :regular
  end
  node :retina do |img| 
    img.asset :retina
  end
end
