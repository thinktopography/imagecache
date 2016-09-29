# encoding: utf-8

module Imagecache
  module Backends
    class Filesystem

      def initialize(root = nil)
        @root = root || "#{Rails.root}/public"
      end

      def get(key)
        File.open(path(key)).read
      end

      def set(key, value)
        keypath = path(key)
        mkdir(keypath)
        File.open(keypath, 'wb') { |file| file.write(value) }
      end

      def delete(key)
        keypath = path(key)
        File.unlink(keypath)
        rmdir(keypath)
      end

      def exists?(key)
        File.exist?(path(key))
      end

      private

        def path(key)
          "#{@root}/#{key}"
        end

        def mkdir(filepath)
          directories = File.dirname(filepath).split("/").drop(1)
          fullpath = ""
          directories.each do |directory|
            fullpath += "/#{directory}"
            if !Dir.exists?(fullpath)
              Dir.mkdir(fullpath)
            end
          end
        end

      def rmdir(filepath)
        directories = File.dirname(filepath).split("/")
        while(directories.any?)
          fullpath = directories.join("/")
          if Dir["#{fullpath}/*"].empty?
            Dir.delete(fullpath)
          end
          directories.pop
        end
      end

    end
  end
end