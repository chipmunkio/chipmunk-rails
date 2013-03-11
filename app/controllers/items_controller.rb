class ItemsController < ApplicationController

    def index

        # will need to add a geo filter when we do that

        # consider shortening the key names to reduce amount of data that must be
        # sent

        # for the values of the keys that do not actually exist in the particular
        # model, consider setting them to a default value instead of null
        # (0,"".)
        
        # consider making the item belong to venue and link and make that
        # association polymorphic then just query items once

        @items = Item.find_by_sql(
                    'SELECT image, minutes, name, latitude, longitude,
                    address, link_type FROM (
                                  SELECT  "items".img_url as image, 
                                          "items".minutes as minutes,
                                          "items".name as name,
                                          "venues".latitude as latitude,
                                          "venues".longitude as longitude, 
                                          "venues".address as address,
                                          NULL as link_type, 
                                          NULL as url From "items" 
                                   INNER JOIN "venues" ON "venues".item_id="items".id
                                   UNION
                                   SELECT "items".img_url as image, 
                                          "items".minutes as minutes,
                                          "items".name as name,
                                          NULL as latitude,
                                          NULL as longitude,
                                          NULL as address,
                                          "links".link_type as link_type,
                                          "links".url as url From "items" 
                                   INNER JOIN "links" ON "links".item_id="items".id
                    ) a
                    ORDER BY minutes DESC, RANDOM()')

        render :json => @items
    end

end
