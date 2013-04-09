object @item

attribute :id
attribute :item_type
attribute :minutes
attribute :name
attribute :url => :original_url
attribute :word_count

node :url do |item|
  "http://chipmunk.io/api/items/#{item.id}/read#content"
end

child :image => :image do
  node :regular do |img| 
    img.asset :regular
  end
  node :retina do |img| 
    img.asset :retina
  end
end
