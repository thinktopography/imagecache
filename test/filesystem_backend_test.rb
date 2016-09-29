require 'minitest/autorun'

class FilesystemBackendTest < Minitest::Test

  def test_can_get_file
    File.open("#{Rails.root}/tmp/#{key}") { |file| file.write(data) }
    value = Imagecache::Backends::Filesystem.new("#{Rails.root}/tmp").get(key)
    asset_equal(data, value)
    File.unlink("#{Rails.root}/tmp/#{key}")
  end

  def test_can_set_file
    Imagecache::Backends::Filesystem.new("#{Rails.root}/tmp").set(key, data)
    value = File.open("#{Rails.root}/tmp/#{key}").read
    asset_equal(data, value)
    File.unlink("#{Rails.root}/tmp/#{key}")
  end

  def test_can_delete_file
    File.open("#{Rails.root}/tmp/#{key}") { |file| file.write(data) }
    Imagecache::Backends::Filesystem.new("#{Rails.root}/tmp").delete(key)
    exists = File.exist?("#{Rails.root}/tmp/#{key}")
    asset_equal(exists, false)
  end

  def test_for_file_existence
    exists = Imagecache::Backends::Filesystem.new("#{Rails.root}/tmp").exists(key)
    asset_equal(exists, false)
    File.open("#{Rails.root}/tmp/#{key}") { |file| file.write(data) }
    exists = Imagecache::Backends::Filesystem.new("#{Rails.root}/tmp").exists(key)
    asset_equal(exists, true)
    File.unlink("#{Rails.root}/tmp/#{key}")
  end

  def data
    "This is data"
  end

  def key
    "assets/12345/test.jpg"
  end

end
