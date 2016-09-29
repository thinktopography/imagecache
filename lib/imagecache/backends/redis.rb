# encoding: utf-8

module Imagecache
  module Backends
    class Redis

      def get(key)
        redis.get(key)
      end

      def set(key, value)
        redis.set(key, value)
      end

      def delete(key)
        redis.del(key)
      end

      def exists?(key)
        redis.exists(key)
      end

      private

        def redis
          @redis ||= ::Redis.new(:host => config['host'], :port => config['port'], :db => config['cache'])
        end

        def config
          @config ||= YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]
        end

    end
  end
end