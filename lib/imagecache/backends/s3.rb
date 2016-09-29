# encoding: utf-8

module Imagecache
  module Backends
    class S3

      def get(key)
        objects[key].read
      end

      def set(key, value)
        headers = { acl: 'public-read', cache_control: 'max-age=315360000, no-transform, public' }
        objects.create(key, value, headers)
      end

      def delete(key)
        objects[key].delete
      end

      def exists?(key)
        objects[key].exists?
      end

      private

        def objects
          s3.buckets[config['bucket']].objects
        end

        def s3
          @s3 ||= AWS::S3.new(:access_key_id => config['access_key_id'], :secret_access_key => config['secret_access_key'])
        end

        def config
          @config ||= YAML.load_file("#{Rails.root}/config/aws.yml")[Rails.env]
        end

    end
  end
end