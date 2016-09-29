# encoding: utf-8

module Imagecache
  class Base

    def process(path)
      url = url_reader.read(path)
      if original = source(url.assetpath)
        if converted = converter.convert(original, url.conversions)
          newurl = url_writer.write(url.conversions, url.assetpath)
          filesystem.set(newurl, converted.data)
          return converted
        end
      end
      nil
    end

    private

      def source(path)
        if filesystem.exists?(path)
          filesystem.get(path)
        elsif s3.exists?(path)
          s3.get(path)
        else
          nil
        end
      end

      def converter
        @converter ||= Imagecache::Converter.new
      end

    def url_reader
      @url_reader ||= Imagecache::UrlReader.new
    end

      def url_writer
        @url_writer ||= Imagecache::UrlWriter.new
      end

      def filesystem
        @filesystem ||= Imagecache::Backends::Filesystem.new
      end

      def s3
        @s3 ||= Imagecache::Backends::S3.new
      end

  end
end
