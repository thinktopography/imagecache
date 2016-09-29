# encoding: utf-8

module Imagecache
  module Conversions
    class Resize

      def process(file, metadata, conversion)
        width = conversion.width
        height = conversion.height
        command = "convert #{file.path} -resize #{width}x#{height} #{file.path}"
        Rails.logger.debug(command)
        output = `#{command}`
        data = File.open(file.path).read
        File.unlink(file.path)
        data
      end

    end
  end
end