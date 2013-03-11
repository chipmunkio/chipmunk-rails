class Api::ItemsController < ApplicationController
  def query 
    #@items = Item.find(:all, :select => "id, name, minutes, img_url, details_type")
    
    @items = Item.page(params[:page]).minutes(params[:minutes])

# the below block should join the details into the item
# I could not test because rails is not completely setup 
# on my computer -AC
=begin
<<<<<<< HEAD
    @items.each { |x|
        details = x.details
        x.merge(details)
=======
    @items.map! { |x|
        details = {}
        if x.details_id == 'venue'
            details = Venue.find(x.details_id)
        elsif x.details_id == 'link'
            details = Link.find(x.details_id)
        end
        x.merge(details.attributes)
>>>>>>> 975cc58e6014ba3bf529c1ca71595d13f2b82ba4
    }
=end
            
    render :json => @items
  end

  def index
    @items = Item.find_by_sql(
        'SELECT name, minutes, img_url, details_type, url, link_type,
                address, latitude, longitude FROM (
                    SELECT  "items".name as name,
                            "items".minutes as minutes,
                            "items".img_url as img_url,
                            "items".details_type as details_type,
                            "links".url as url,
                            "links".link_type as link_type,
                            NULL as address,
                            NULL as latitude,
                            NULL as longitude FROM "items"
                    INNER JOIN "links" ON "items".details_id="links".id
                    UNION
                    SELECT  "items".name as name,
                            "items".minutes as minutes,
                            "items".img_url as img_url,
                            "items".details_type as details_type,
                            NULL as link_url,
                            NULL as link_type,
                            "venues".address as address,
                            "venues".latitude,
                            "venues".longitude FROM "items"
                    INNER JOIN "venues" ON "items".details_id="venues".id
        ) a
        ORDER BY minutes DESC, RANDOM()')

    render :json => @items
  end
  
  def show
    @item = Item.find params[:id]
    render :json => @item
    #@item = Item.find params[:id]
  end
  
  def new
    @link = Link.new
    @link.build_item
    
    @venue = Venue.new
    @venue.build_item
  end
  
  def create
    if (params[:link])
      Link.create params[:link]
    elsif (params[:venue])
      Venue.create params[:venue]
    end
    redirect_to :back
  end
end

