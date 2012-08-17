module Appfigures
  class Sales
    attr_reader :connection
    def initialize
      @connection = Appfigures.connection
    end

    def products
      self.connection.get('sales/products').body.map do |id, hash|
        Hashie::Mash.new({
          'product_id'      => hash['product']['id'],
          'store_id'        => hash['product']['store_id'],
          'store_name'      => hash['product']['store_name'],
          'name'            => hash['product']['name'],
          'sku'             => hash['product']['sku'],
          'downloads'       => hash['downloads'].to_i,
          'returns'         => hash['returns'].to_i,
          'updates'         => hash['updates'].to_i,
          'net_downloads'   => hash['net_downloads'].to_i,
          'promos'          => hash['promos'].to_i,
          'gift_redemptions'=> hash['gift_redemptions'].to_i,
          'revenue'         => hash['revenue'].to_f
        })
      end
    end

    # GET /sales/products+dates/2010-05-20/2010-05-25
    def products_dates(start_date, end_date)
      self.connection.get("sales/products+dates/#{start_date}/#{end_date}").body.map do |id, hash|
        Hashie::Mash.new({
          'product_id' => hash['id'],
          'series' => hash.map |date, data| { Hashie::Mash.new({'date' => date, 'downloads' => data['downloads']}) }
        })
      end
    end
  end
end
