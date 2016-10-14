# encoding: utf-8

module Imagecache

  class Converter

    def convert(data, conversions)
      (1..conversions.length).each do
        data = _convert(assetpath, conversions)
      end
      file = file(data)
      metadata = identify.identify(file)
      File.unlink(file.path)
      OpenStruct.new(data: data, content_type: metadata.content_type)
    end


    def _convert(assetpath, conversions)
      source = (conversions.length > 1) ? url_writer.write(conversions[0, (conversions.size - 1)], assetpath) : assetpath
      destination = url_writer.write(conversions, assetpath)
      if filesystem.exists?(destination)
        data = filesystem.get(destination)
        return data
      elsif filesystem.exists?(source)
        data = filesystem.get(source)
        file = file(data)
        metadata = identify.identify(file)
        newdata = process(file, metadata, conversion)
        newurl = url_writer.write(conversions, assetpath)
        filesystem.set(newurl, converted.data)
        return newdata
      end
    end

    private

      def processor
        @processor ||= Imagecache::Convert.new
      end

      def process(file, metadata, conversion)
        if conversion.action == 'resize'
          converter = Imagecache::Conversions::Resize.new
        elsif conversion.action == 'crop'
          converter = Imagecache::Conversions::Crop.new
        elsif conversion.action == 'round'
          converter = Imagecache::Conversions::Round.new
        elsif conversion.action == 'fit'
          converter = Imagecache::Conversions::Fit.new
        end
        converter.process(file, metadata, conversion)
      end

      def file(data)
        filename = SecureRandom.hex(32).to_s.upcase[0,8]
        filepath = "#{Rails.root}/tmp/#{filename}"
        file = File.open(filepath, 'wb')
        file.write(data)
        file.close if file && !file.closed?
        file
      end

      def identify
        @identify ||= Imagecache::Identify.new
      end

  end

end
