# encoding: utf-8

module Imagecache
  class UrlReader

    def read(path)
      if path =~ /imagecache\/([^\/]*)\/(.*)/
        assetpath = $2
        conversions = parse_conversions($1)
        OpenStruct.new({ conversions: conversions, assetpath: assetpath })
      end
    end

    private

      def parse_conversions(conversions)
        output = []
        conversions.split("-").each do |conversion|
          if conversion.downcase =~ /^rs(\d*)x(\d*)$/
            output << OpenStruct.new({ action: 'resize', width: $1.to_i, height: $2.to_i })
          elsif conversion.downcase =~ /^wd(\d*)$/
            output << OpenStruct.new({ action: 'width', width: $1.to_i })
          elsif conversion.downcase =~ /^rd(\d*)$/
            output << OpenStruct.new({ action: 'round', radius: $1.to_i })
          elsif conversion.downcase =~ /^ht(\d*)$/
            output << OpenStruct.new({ action: 'height', height: $1.to_i })
          elsif conversion.downcase =~ /^ft(\d*)x(\d*)$/
            output << OpenStruct.new({ action: 'fit', width: $1.to_i, height: $2.to_i })
          elsif conversion.downcase =~ /^cp(\d*)x(\d*)\+(\d*)\+(\d*)$/
            output << OpenStruct.new({ action: 'crop', width: $1.to_i, height: $2.to_i, x: $3.to_i, y: $4.to_i })
          end
        end
        output
      end

  end
end