# encoding: utf-8

module Imagecache
  class UrlWriter

    def write(conversions, assetpath)
      "imagecache/#{join(conversions)}/#{assetpath}"
    end

    private

      def join(conversions)
        output = []
        conversions.each do |conversion|
          if conversion.action == 'resize'
            output << "rs#{conversion[:width]}x#{conversion[:height]}"
          elsif conversion.action == 'width'
            output << "wd#{conversion[:width]}"
          elsif conversion.action == 'height'
            output << "ht#{conversion[:height]}"
          elsif conversion.action == 'round'
            output << "rd#{conversion[:radius]}"
          elsif conversion.action == 'crop'
            output << "cp#{conversion[:width]}x#{conversion[:height]}+#{conversion[:x]}+#{conversion[:y]}"
          end
        end
        output.join("-")
      end

  end
end