# encoding: utf-8

module Imagecache

  module Conversions

    class Round

      def process(file, metadata, conversion)
        shortest = [metadata.width, metadata.height].min
        radius = (conversion.radius / 100.to_f) * shortest
        command = command(file.path, radius)
        `#{command}`
        data = File.open("#{file.path}.png").read
        File.unlink("#{file.path}.png")
        File.unlink(file.path)
        data
      end

      private

        def command(filepath, radius)
          arguments = []
          arguments << '\( +clone  -alpha extract'
          arguments << "-draw 'fill black polygon 0,0 0,#{radius} #{radius},0 fill white circle #{radius},#{radius} #{radius},0'"
          arguments << '\( +clone -flip \) -compose Multiply -composite'
          arguments << '\( +clone -flop \) -compose Multiply -composite'
          arguments << '\) -alpha off -compose CopyOpacity -composite'
          "convert #{filepath} #{arguments.join(' ')} #{filepath}.png"
        end

    end

  end

end
