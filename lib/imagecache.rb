# encoding: utf-8

module Imagecache
  require 'imagecache/backends/filesystem'
  require 'imagecache/backends/redis'
  require 'imagecache/backends/s3'
  require 'imagecache/conversions/crop'
  require 'imagecache/conversions/fit'
  require 'imagecache/conversions/resize'
  require 'imagecache/conversions/round'
  require 'imagecache/base'
  require 'imagecache/identify'
  require 'imagecache/converter'
  require 'imagecache/url_reader'
  require 'imagecache/url_writer'
end